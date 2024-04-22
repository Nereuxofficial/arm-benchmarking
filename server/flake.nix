{
  description = "Benchmarking x86 -> aarch64 emulation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs }: {
  	
	  packages.aarch64-linux.postgresql_aarch64 = nixpkgs.legacyPackages.aarch64-linux.postgresql_16;

	  packages.aarch64-linux.postgresql_x86_64 = nixpkgs.legacyPackages.x86_64-linux.postgresql_16;
    
    packages.aarch64-linux.qemu = nixpkgs.legacyPackages.aarch64-linux.qemu;

	  packages.aarch64-linux.default = self.packages.aarch64-linux.postgresql_aarch64;

    packages.aarch64-linux.hyperfine = nixpkgs.legacyPackages.aarch64-linux.hyperfine;

    apps.aarch64.postgresql = {
      type = "app";
      package = self.packages.aarch64-linux.default;
    };
    apps.aarch64.postgresql_x86_64 = {
      type = "app";
      pre = {
        inputs = {
          qemu = self.packages.aarch64-linux.qemu;
        };
      };
      package = self.packages.aarch64-linux.postgresql_x86_64;
    };

    devShell.aarch64-linux = nixpkgs.mkShell {
      packages = [
        self.packages.aarch64-linux.postgresql_x86_64 
        self.packages.aarch64-linux.qemu 
        self.packages.aarch64-linux.postgresql_aarch64
        self.packages.aarch64-linux.hyperfine
      ];
    };
  };
}
