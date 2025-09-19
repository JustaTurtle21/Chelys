{...}:
{
  imports = [
    ./software.nix
    ./zed.nix
  ];
  nixpkgs.config.allowUnfree = true;
}
