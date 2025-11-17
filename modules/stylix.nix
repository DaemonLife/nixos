{ pkgs
, config
, lib
, ...
}: {
  stylix = {
    enable = true;

    # targets.qt.enable = true;
    # targets.qt.platform = lib.mkForce "gnome";

    # my base
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/horizon-terminal-dark.yaml";

    # blue light free
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";

    image = ../images/medusa.jpg;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 26;
    };

    fonts = {
      monospace = {
        package = pkgs.unifont;
        name = "Unifont";
      };

      sansSerif = config.stylix.fonts.monospace;
      serif = config.stylix.fonts.monospace;
      emoji = config.stylix.fonts.monospace;

      # sansSerif = {
      #   package = config.stylix.fonts.monospace.package;
      #   name = "${config.stylix.fonts.monospace.name}";
      # };
      # serif = {
      #   package = config.stylix.fonts.monospace.package;
      #   name = "${config.stylix.fonts.monospace.name}";
      # };
      # emoji = {
      #   package = pkgs.noto-fonts-emoji;
      #   name = "Noto Color Emoji";
      # };
      sizes = {
        applications = 17;
        terminal = 19;
        # Window titles, status bars, and other general elements of the desktop.
        desktop = 16;
        popups = config.stylix.fonts.sizes.desktop;
      };
    };

    opacity = {
      applications = 1.0;
      terminal = 1.0;
      desktop = 1.0;
      popups = 1.0;
    };

    polarity = "dark";
  };
}
