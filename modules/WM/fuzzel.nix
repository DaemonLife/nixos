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
        vertical-pad = 25;
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

      border.width = config.wayland.windowManager.sway.config.window.border;
      border.radius = 0;
    };
  };
}
