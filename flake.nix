{
  description = "All my personal projects building.";

  inputs = {
    haskellNix.url = "github:input-output-hk/haskell.nix";
    nixpkgs.follows = "haskellNix/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, haskellNix, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            inherit (haskellNix) config;
            overlays = [ haskellNix.overlay ];
          };
        in
        {
          packages.default = pkgs.haskell-nix.cabalProject' {
            src = ./.;
            compiler-nix-name = "ghc966";
          };
        }
      );
}

