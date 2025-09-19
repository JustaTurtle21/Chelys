{
  description = "Starter NixOS flake.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-warez.url = "github:edolstra/nix-warez?dir=blender";
  };
  outputs = inputs@{ ... }: let
    settings = {
      timeZone = "Asia/Dhaka";
      account = {
        name = "justaturtle";
        shell = "zsh";
      };
    };

    system = "x86_64-linux";               # System architecture
    nixpkgs.config.allowUnfree = true;
  in {
    nixosConfigurations.home = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system settings; };
      modules = [
        inputs.home-manager.nixosModules.home-manager
        ./profile/home/hardware.nix
        ./profile/home/configuration.nix
        ./compose.nix
      ];
    };
  };
}
