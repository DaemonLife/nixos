{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.waybar = with config.lib.stylix.colors; {
  };
}
