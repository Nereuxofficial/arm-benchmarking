{
  description = "FEX-Emu build flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    utils.url = "github:numtide/flake-utils";
    utils.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs}: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };
      fex-emu = (with pkgs; stdenv.mkDerivation {
          pname = "fex-emu";
          version = "02ebb6e";
          src = fetchgit {
            url = "https://github.com/FEX-Emu/FEX";
            sha256 = lib.fakeSha256;
            #sha256 = "02ebb6e32074ca26d60727b998d39fe04a2a2465";
            fetchSubmodules = true;
          };
          nativeBuildInputs = [
            clang
            cmake
          ];
          buildPhase = ''
            mkdir Build
            cd Build
            CC=clang CXX=clang++ cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DUSE_LINKER=lld -DENABLE_LTO=True -DBUILD_TESTS=False -DENABLE_ASSERTIONS=False -G Ninja ..
            ninja'';
          installPhase = ''
            sudo ninja install
          '';
        }
      );
    in rec {
      defaultApp = flake-utils.lib.mkApp {
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
