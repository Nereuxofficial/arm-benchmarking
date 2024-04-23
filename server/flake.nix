{
  description = "Benchmarking x86 -> aarch64 emulation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nix_unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nix_unstable }: {
  	
	  packages.aarch64-linux.postgresql_aarch64 = nixpkgs.legacyPackages.aarch64-linux.postgresql_16;

	  packages.aarch64-linux.postgresql_x86_64 = nixpkgs.legacyPackages.x86_64-linux.postgresql_16;
    
    packages.aarch64-linux.qemu = nixpkgs.legacyPackages.aarch64-linux.qemu;

	  packages.aarch64-linux.default = self.packages.aarch64-linux.postgresql_aarch64;

    packages.aarch64-linux.hyperfine = nixpkgs.legacyPackages.aarch64-linux.hyperfine;


    devShell.aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.mkShell {
      # Set environment variables
      shellHook = ''
        export PGDATA="./data"
      '';
      packages = [
        self.packages.aarch64-linux.postgresql_x86_64 
        self.packages.aarch64-linux.qemu 
        self.packages.aarch64-linux.postgresql_aarch64
        self.packages.aarch64-linux.hyperfine
        nixpkgs.legacyPackages.aarch64-linux.proot
        nix_unstable.legacyPackages.x86_64-linux.redict
        nix_unstable.legacyPackages.aarch64-linux.redict
        nixpkgs.legacyPackages.x86_64-linux.scylladb
        nixpkgs.legacyPackages.aarch64-linux.scylladb
      ];
    };
  };
}
