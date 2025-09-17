
{ settings, config, pkgs, ... }: {
  networking.hostName = "kame";
  system.stateVersion = "25.05";
  time.timeZone = settings.timeZone;

  home-manager.users.${settings.account.name} = {
    programs.home-manager.enable = true;
    home.stateVersion = "25.05";
  };

  users.users.${settings.account.name} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    hashedPassword = "$6$5hyTgXD3C7.oANCa$z1Mjb4lxF/NczlmuSC2MM2K9Z1J3Q8Y0xH92F6Vr5WwTuVaENIxBqxs5zVuECCWjXXcW4UuBHEdGhvHcf7MBe/";
    shell = pkgs.${settings.account.shell};
  };
  programs.${settings.account.shell}.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "@wheel" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enables blender with cuda and optix
  nixpkgs.overlays = [ blender-bin.overlays.default ];

  hardware.graphics.enable = true;
  hardware.nvidia.open = false;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
  boot.blacklistedKernelModules = [ "nouveau" ];
  services.xserver.videoDrivers = [ "nvidia" ];
  boot.kernelParams = [
    "nvidia_drm"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia-drm.fbdev=1"
    "nvidia"
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    lexend
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];

  /* Compressed memory */
  services.zram-generator.enable = true;
  services.zram-generator.settings.zram0.zram-size = "ram * 2";

  /* Network */
  networking.firewall.enable = true;
  networking.networkmanager.enable = true;
  # services.openssh.enable = true;

  /* BIOS */
  # boot.loader.grub.enable = true;
  # boot.loader.grub.useOSProber = true;

  /* UEFI */
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub.efiSupport = true;

  /* Uncomment your drive type */
  boot.loader.grub.device =
  # "/dev/vda";     /* Virtual drive     */
   "/dev/sda";     /* Physical drive    */
  #"/dev/nvme0n1"; /* Solid state drive */
}
