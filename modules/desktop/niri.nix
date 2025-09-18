{pkgs, settings, ...}:
{
  environment.systemPackages = with pkgs; [
    niri
    rofi
    waybar
    wezterm
    swww
    dunst
  ];

}
