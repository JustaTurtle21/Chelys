{ pkgs, ... }: {
  imports = [
    # Import any modules or take them out
    ../../modules/desktop/gnome.nix
    ../../modules/apps/apps.nix
    ../../modules/commands/commands.nix
  ];
  # One line to change the kernel, comment out to use latest
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "udev.log_priority=3"
    "rd.systemd.show_status=auto"
  ];
  boot.blacklistedKernelModules = [ ];
}
