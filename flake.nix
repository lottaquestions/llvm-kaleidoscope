{
  description = "virtual environments";

  inputs.devshell.url = "github:numtide/devshell";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, flake-utils, devshell, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system: {
      devShell =
        let pkgs = import nixpkgs {
              inherit system;
              overlays = [ devshell.overlay ];
            };
            mkDrv = with pkgs; { llvmVersion ? "10", chapter }:
              let llvmPackages = pkgs."llvmPackages_${llvmVersion}";
              in (llvmPackages.stdenv.mkDerivation rec {
                pname = "${chapter}";
                version = "${llvmVersion}";
                src = "${self}/${chapter}";
                nativeBuildInpts = [ binutils coreutils llvmPackages.clang ];
                buildInputs = [ llvmPackages.llvm ];
                buildPhase = "clang++ -lLLVM-${llvmVersion} -std=c++14 toy.cpp -o toy.bin";
                installPhase = ''
                        ${coreutils}/bin/mkdir -pv $out/bin
                        ${rsync}/bin/rsync -avz toy.bin $out/bin
                      '';
              });
        in
          pkgs.devshell.mkShell {
            name = "kaleidoscope";
            commands = [
              (rec {
                name = "chapter2";
                category = "kaleidscope";
                command = let package = mkDrv { chapter = "Chapter2_Implementing_a_Parser_and_AST"; }; in "${package}/bin/toy.bin";
              })
              (rec {
                name = "chapter3";
                category = "kaleidscope";
                command = let package = mkDrv { chapter = "Chapter3_Code_Generation_to_LLVM"; }; in "${package}/bin/toy.bin";
              })
            ];
          };
    });
}
