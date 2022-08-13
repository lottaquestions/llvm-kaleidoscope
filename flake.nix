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
        in
          pkgs.devshell.mkShell {
            name = "kaleidoscope";
            imports = [ (pkgs.devshell.importTOML ./devshell.toml) ];
            packages = with pkgs;
              let mkDrv = { llvmVersion ? "10", chapter }:
                    let llvmPackages = llvmPackages_10;
                    in (llvmPackages.stdenv.mkDerivation rec {
                      pname = "${chapter}";
                      version = "${llvmVersion}";
                      src = "${self}/${chapter}";
                      nativeBuildInpts = [ binutils coreutils llvmPackages.clang ];
                      buildInputs = [ llvmPackages.llvm ];
                      buildPhase = "clang++ -lLLVM-${llvmVersion} -std=c++14 toy.cpp -o toy.bin";
                      installPhase = ''
                        ${coreutils}/bin/mkdir -pv $out/${chapter}/bin
                        ${rsync}/bin/rsync -avz toy.bin $out/${chapter}/bin
                      '';
                    });
              in [
                ( mkDrv { chapter = "Chapter2_Implementing_a_Parser_and_AST"; })
                ( mkDrv { chapter = "Chapter3_Code_Generation_to_LLVM"; })
              ];
          };
    });
}
