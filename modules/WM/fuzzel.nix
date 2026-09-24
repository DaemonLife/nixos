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
        show-actions = "yes";
        horizontal-pad = 22;
        vertical-pad = 25;
        exit-on-keyboard-focus-loss = "yes";
        font = lib.mkForce "${config.stylix.fonts.monospace.name}:size=${toString config.stylix.fonts.sizes.terminal}";
      };

      colors = {
        # background = "${base00}ff";
        text = lib.mkForce "${base05}ff";
        match = lib.mkForce "${base08}ff";
        selection = lib.mkForce "${base02}ff";
        selection-match = lib.mkForce "${base08}ff";
        selection-text = lib.mkForce "${base05}ff";
        # border = "${base0D}ff";
      };

      border.width = 4;
      border.radius = 0;
    };
  };
}
