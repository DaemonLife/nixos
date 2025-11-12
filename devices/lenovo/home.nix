{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [./modules/_import.nix];

  # pkgs only for lenovo
  home.packages = with pkgs; [
    # media
    digikam
    # blender
    darktable

    # games
    bottles
  ];

  dconf.settings = {
    "org/gnome/desktop/peripherals/touchpad" = {speed = 0.8;};
  };
}
