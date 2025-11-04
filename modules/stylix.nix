{
  pkgs,
  config,
  ...
}: {
  stylix = {
    enable = true;

    # my base
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/horizon-terminal-dark.yaml";

    # blue light free
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";

    image = ../images/img6_dark.jpg;

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
      sansSerif = {
        package = config.stylix.fonts.monospace.package;
        name = "${config.stylix.fonts.monospace.name}";
      };
      serif = {
        package = config.stylix.fonts.monospace.package;
        name = "${config.stylix.fonts.monospace.name}";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 21;
        popups = 21;
        terminal = 20;
        desktop = 21;
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
