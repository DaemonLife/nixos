{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./mako.nix
    ./sway.nix
    # ./hyprland.nix
  ];
}
