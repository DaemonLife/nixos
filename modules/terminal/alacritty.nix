{ config, ... }: {

  programs.alacritty = with config.lib.stylix.colors; {
    enable = true;

    settings = {

      window = {
        # decorations = "None";
        title = "Terminal";
        padding.x = 4;
        padding.y = 0;
      };

      # font = lib.mkForce {
      #   normal = { family = "GeistMono Nerd Font Mono"; style = "Regular"; };
      #   bold = { family = "GeistMono Nerd Font Mono"; style = "Bold"; };
      #   italic = { family = "GeistMono Nerd Font Mono"; style = "Italic"; };
      #   bold_italic = { family = "GeistMono Nerd Font Mono"; style = "Bold Italic"; };
      # };

      terminal = {
        shell = "fish";
      };

    };
  };
}
