{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [./modules/_import.nix];

  dconf.settings = {
    "org/gnome/desktop/peripherals/touchpad" = {speed = 0.8;};
  };
}
