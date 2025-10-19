{
  config,
  lib,
  ...
}: {
  programs.fuzzel = with config.lib.stylix.colors; {
    enable = true;
    settings = {
      main = {
        # dpi-aware = "auto";
        icons-enabled = "no";
        show-actions = "no";
        horizontal-pad = 25;
        vertical-pad = 35;
        exit-on-keyboard-focus-loss = "yes";
      };

      colors = {
        # background = "${base00}ff";
        text = lib.mkForce "${base05}ff";
        match = lib.mkForce "${base0D}ff";
        selection = lib.mkForce "${base0D}ff";
        selection-match = lib.mkForce "${base07}ff";
        selection-text = lib.mkForce "${base01}ff";
        # border = "${base0D}ff";
      };

      border.width = 6; # like sway's border * 1.5
      border.radius = 0;
    };
  };
}
