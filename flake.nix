{
  description = "MT7601U kernel driver patch for AP mode";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, config }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = nixpkgs.legacyPackages.${system}; in
        {
          packages.default = import ./default.nix { kernel = config.boot.kernelPackages.kernel };
        }
      );
}


