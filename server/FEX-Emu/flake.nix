{
  description = "FEX-Emu build flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    utils.url = "github:numtide/flake-utils";
    utils.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, utils}: utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };
      stdenv = pkgs.clangStdenv;
      fex-emu = (with pkgs; stdenv.mkDerivation {
          pname = "fex-emu";
          version = "02ebb6e";
          src = fetchgit {
            url = "https://github.com/FEX-Emu/FEX";
            sha256 = "sha256-nweeAuMCEs/iFXXJ5pk9upFJpzVFNERDFmpOIT4q0QI=";
            fetchSubmodules = true;
          };
          buildInputs = [
            epoxy
            SDL2
            ninja
            llvm
            squashfuse
            erofs-utils
          ];
          nativeBuildInputs = [
            clang
            cmake
            llvm
            pkg-config
            python3
            nasm
            git
            lld
          ];
          buildPhase = ''
            rm -r * # i have ZERO clue why nix builds the package using Unix makefiles first but here we are
            CC=clang CXX=clang++ cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DUSE_LINKER=lld -DENABLE_LTO=True -DBUILD_TESTS=False -DENABLE_ASSERTIONS=False -G Ninja ".."
            ninja
            '';
          installPhase = ''
            ls -la
            mkdir -p $out/bin
            cp -r Bin/ $out/bin/
          '';
        }
      );
    in rec {
      defaultApp = utils.lib.mkApp {
        drv = defaultPackage;
      };
      defaultPackage = fex-emu;
      devShell = pkgs.mkShell {
        buildInputs = [
          fex-emu
        ];
      };
    }
  );
}
