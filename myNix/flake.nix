{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    helium.url = "github:FKouhai/helium2nix/main";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plugins-lze = {
    	url = "github:BirdeeHub/lze";
    	flake = false;
    };
    plugins-lzextras = {
    	url = "github:BirdeeHub/lzextras";
	flake = false;
    };
    
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wrappers.url = "github:Lassulus/wrappers";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
}
