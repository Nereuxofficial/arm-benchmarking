{
  description = "Benchmarking suite - server side";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs}: {
  	
	#packages.aarch64-linux.default = "nixos:release-23.11:nixpkgs.hl5gaz0ynxawk19pz0h440ylvw89pxv3-postgresql_16_jit.aarch64-linux";
	packages.aarch64-linux.postgresql_aarch64 = "nixos:release-23.11:nixpkgs.hl5gaz0ynxawk19pz0h440ylvw89pxv3-postgresql_16_jit.aarch64-linux";

	packages.aarch64-linux.postgresql_x86_64 = "nixos:release-23.11:nixpkgs.hl5gaz0ynxawk19pz0h440ylvw89pxv3-postgresql_16_jit.x86_64-linux";
  };
}
