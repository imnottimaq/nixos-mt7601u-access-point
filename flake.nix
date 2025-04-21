{
  description = "MT7601U kernel driver patch for AP mode";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
	        pkgs = nixpkgs.legacyPackages.${system};
	        inherit (nixpkgs) lib;
	      in
          {
            packages.default = pkgs.callPackage ./default.nix { };
          }
      );
}
