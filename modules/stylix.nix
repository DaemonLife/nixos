{ pkgs, config, lib, ... }: {
  stylix = {
    enable = true;

    image = ../images/medusa.jpg;

    # based theme 
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/horizon-terminal-dark.yaml";

    # blue light free theme!
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-hard.yaml";

    # cursor = {
    #   package = pkgs.bibata-cursors;
    #   name = "Bibata-Modern-Ice";
    #   size = 26;
    # };

    # fonts = {
    #   monospace = {
    #     package = pkgs.unifont;
    #     name = "Unifont";
    #   };
    #   sansSerif = {
    #     package = pkgs.unifont;
    #     name = "Unifont";
    #   };
    #   serif = {
    #     package = pkgs.unifont;
    #     name = "Unifont";
    #   };
    #   emoji = {
    #     package = pkgs.unifont;
    #     name = "Unifont";
    #   };
    #
    #   sizes = {
    #     # be careful when using certain values (for example 19)
    #     # check fonts settings in qt6ct program for valid values (I hate it)
    #     applications = 18;
    #     terminal = 18;
    #     # Window titles, status bars, and other general elements of the desktop.
    #     desktop = 16;
    #     popups = config.stylix.fonts.sizes.desktop;
    #   };
    # };

    opacity = {
      applications = 1.0;
      terminal = 1.0;
      desktop = 1.0;
      popups = 1.0;
    };

    polarity = "dark";
  };

  # QT STUFF WORKS DON'T TOUCH IT
  qt.enable = lib.mkForce true;
  stylix.targets.qt.enable = lib.mkForce true;
}
