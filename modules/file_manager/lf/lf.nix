{ pkgs, config, ... }: {

  xdg.configFile."lf/icons".source = ./icons;

  programs.lf = {
    enable = true;
    commands = {
      editor-open = "$hx $f";
      mkdir = ''
        ''${{
          printf "Directory Name: "
          read DIR
          mkdir $DIR
        }}
      '';
    };

    previewer = {
      keybinding = "i";
      source = "${pkgs.ctpv}/bin/ctpv";
    };
    extraConfig = ''
      &${pkgs.ctpv}/bin/ctpv -s $id
      cmd on-quit %${pkgs.ctpv}/bin/ctpv -e $id
      set cleaner ${pkgs.ctpv}/bin/ctpvclear
    '';

    keybindings = {
      # My
      mkdir = "mkdir";
      "." = "set hidden!";
      "<enter>" = "open";
      ee = "editor-open";
      gw = "cd /mnt/windows/Users/user";
      gh = "cd";
      gn = "cd ~/nix";
    };

    settings = {
      preview = true;
      hidden = false;
      drawbox = true;
      icons = false;
      ignorecase = true;
    };

    # extraConfig = let
    #   previewer = pkgs.writeShellScriptBin "pv.sh" ''
    #     file=$1
    #     w=$2
    #     h=$3
    #     x=$4
    #     y=$5
    #
    #     if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
    #         ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
    #         exit 1
    #     fi
    #
    #     ${pkgs.pistol}/bin/pistol "$file"
    #   '';
    #   cleaner = pkgs.writeShellScriptBin "clean.sh" ''
    #     ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
    #   '';
    # in ''
    #   set cleaner ${cleaner}/bin/clean.sh
    #   set previewer ${previewer}/bin/pv.sh
    # '';
  };

}
