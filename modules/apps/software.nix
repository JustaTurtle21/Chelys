{ inputs, pkgs, settings, ... }: let
    # Bring in the unstable channel
    unstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
in{
  # This line says what packages your user should have
  # installed, they aren't shared with root or other users
  home-manager.users.${settings.account.name}.home.packages = with pkgs; [
    # Use the prefix 'unstable.' for unstable packages
    firefox
    vim
    bottles
    distrobox
    inputs.nix-warez.packages.${system}.blender_4_5
  ];
  # Check https://search.nixos.org/packages to see which packages are available
}
