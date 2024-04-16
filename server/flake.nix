{
  description = "Benchmarking x86 -> aarch64 emulation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs }: {
  	
	  packages.aarch64-linux.postgresql_aarch64 = nixpkgs.legacyPackages.aarch64-linux.postgresql_16;

	  packages.aarch64-linux.postgresql_x86_64 = nixpkgs.legacyPackages.x86_64-linux.postgresql_16;

	  packages.aarch64-linux.default = self.packages.aarch64-linux.postgresql_aarch64;
  };
}
