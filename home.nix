{
  config,
  pkgs,
  lib,
  username,
  ...
}: {
  imports = [./modules/_import.nix];

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    sessionPath = ["/home/${username}/.local/bin"];
    sessionVariables = let
      EDITOR = "vi";
    in {
      EDITOR = "${EDITOR}";
      SYSTEMD_EDITOR = "${EDITOR}";
      VISUAL = "${EDITOR}";
      BROWSER = "qutebrowser";
      TERMINAL = "foot";
      # MANGOHUD = 1; # Steam performance GUI
    };
    stateVersion = "24.05";

    # --------------------------------
    # HOME PKGS
    # --------------------------------

    packages = with pkgs; [
      wl-clipboard
      unzip
      python3
      nodejs # for run javascript
      pipx
      exiftool
      imagemagick
      zip
      fzy
      dua # disk usage TUI tool. Run: dua i

      # Network
      overskride # bluetooth gui
      bluetui # bluetooth tui
      telegram-desktop
      tg
      unstable.nchat
      bitwarden-cli
      qbittorrent # torrent client
      tor-browser

      # Media
      gimp3-with-plugins
      helvum # A GTK patchbay for pipewire
      digikam
      blender
      unstable.darktable
      imagemagick
      ffmpegthumbnailer
      mlt
      pavucontrol # audio gui control
      alsa-utils # audio volume control (?)
      pulsemixer # cli pulse adudio control
      nomacs-qt6 # image viewer
      kodi-wayland

      # Theming
      vimix-icon-theme # cursor icon
      gnome-tweaks
      gowall # Tool to convert a Wallpaper's color scheme
      grc
      fontpreview # --preview-text "Привет, как дела, это просто тест шрифта!!! 1234567890?*# Just a test for my font."
      ## Fonts
      unifont_upper
      unifont-csur

      # Utils
      dconf-editor
      cool-retro-term
      bottles
      veracrypt
      cmatrix # matrix in terminal
      wev # key events in wayland
      nwg-displays # gui for display setup
      gucharmap # character map
      ansible

      # Docs
      onlyoffice-desktopeditors
      jrnl
      joplin
      stellarium # astro map
      astroterm # astro map ASCII
      epy # cli book reader
      tldr # community documentation
      russ # rss tui reader
      gnome-feeds # gui rss reader

      # Gaming
      portablemc # minecraft cli launcher
      curseofwar # stategy cli game
      vitetris # tetris cli game
      mindustry-wayland
      # dwarf-fortress-packages.dwarf-fortress-full

      libreoffice
      hunspell # spellcheck for LibreOffice
      hunspellDicts.ru_RU # spellcheck for LibreOffice
      hunspellDicts.en_US # spellcheck for LibreOffice
    ];
  };

  # --------------------------------
  # HOME PROGRAMS
  # --------------------------------

  programs = {
    fastfetch = {
      enable = true;
    };
    yt-dlp = {
      enable = true;
    };
    imv = {
      enable = true;
    };

    bash = {
      initExtra = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };

    btop = {
      enable = true;
      settings = {
        color_theme = lib.mkForce "TTY";
        theme_background = lib.mkForce false;
        rounded_corners = lib.mkForce false;
        vim_keys = lib.mkForce true;
      };
    };
  };

  dconf = {
    settings = {
      "org/gnome/desktop/wm/preferences" = {
        button-layout = ""; # disable top right buttons
      };
      "org/gnome/desktop/peripherals/touchpad" = {
        tap-and-drag = false;
        tap-and-drag-lock = false;
        natural-scroll = false;
        accel-profile = "adaptive";
      };
      "org/gnome/desktop/peripherals/mouse" = {
        natural-scroll = false;
        accel-profile = "adaptive";
      };
    };
  };
}
