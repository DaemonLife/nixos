# Not all is declarative! You need install and sometimes update plugins. Check 'ya --help' for details, 'ya -l' for list plugins.
# Installation:
# ya pkg add atareao/convert
{
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    dragon-drop
    bat
    eza
    glow
    ouch
    mediainfo
    imagemagick
    trash-cli
    ffmpeg-full
  ];

  programs.yazi = with config.lib.stylix.colors; {
    package = pkgs.unstable.yazi;
    enable = true;
    enableFishIntegration = true;

    initLua = ''
      require("session"):setup {
      	sync_yanked = true,
      }
      require("git"):setup()
      require("recycle-bin"):setup()
    '';

    plugins = with pkgs.yaziPlugins; {
      # name = nix_pkg_name

      mount = mount; # mount control
      # Key Action
      # q   Quit the plugin
      # k	Move up
      # j   Move down
      # l   Enter the mount point
      # m   Mount the partition
      # u   Unmount the partition
      # e   Eject the disk

      smart-enter = smart-enter; # enter to directories
      smart-filter = smart-filter; # cool search+filter
      git = git; # files git status
      piper = piper; # preview with shell commands
      relative-motions = relative-motions; # vim keys
      ouch = ouch; # archive preview and compress
      recycle-bin = recycle-bin; # system trash bin support
      mediainfo = mediainfo;

      # mime-ext = mime-ext; # fast mime-type by file extancions
    };

    settings = {
      floating_window_scaling_factor = 0.5;
      plugin = {
        prepend_fetchers = [
          # --- plugin mime-ext ---
          # {
          #   id = "mime";
          #   name = "*";
          #   run = "mime-ext";
          #   prio = "high";
          # }
          # --- plugin git ---
          {
            id = "git";
            name = "*";
            run = "git";
          }
          {
            id = "git";
            name = "*/";
            run = "git";
          }
        ];
        # --- plugin mediainfo ---
        prepend_preloaders = [
          {
            mime = "{audio,video,image}/*";
            run = "mediainfo";
          }
          {
            mime = "application/subrip";
            run = "mediainfo";
          }
          {
            mime = "application/postscript";
            run = "mediainfo";
          }
        ];

        prepend_previewers = [
          # --- plugin mediainfo ---
          {
            mime = "{audio,video,image}/*";
            run = "mediainfo";
          }
          {
            mime = "application/subrip";
            run = "mediainfo";
          }
          {
            mime = "application/postscript";
            run = "mediainfo";
          }
        ];
        append_previewers = [
          # --- Ouch archive previewer ---
          {
            mime = "application/*zip";
            run = "ouch";
          }
          {
            mime = "application/x-tar";
            run = "ouch";
          }
          {
            mime = "application/x-bzip2";
            run = "ouch";
          }
          {
            mime = "application/x-7z-compressed";
            run = "ouch";
          }
          {
            mime = "application/x-rar";
            run = "ouch";
          }
          {
            mime = "application/vnd.rar";
            run = "ouch";
          }
          {
            mime = "application/x-xz";
            run = "ouch";
          }
          {
            mime = "application/xz";
            run = "ouch";
          }
          {
            mime = "application/x-zstd";
            run = "ouch";
          }
          {
            mime = "application/zstd";
            run = "ouch";
          }
          {
            mime = "application/java-archive";
            run = "ouch";
          }
          {
            name = "*.csv";
            run = "piper -- bat -p --color=always '$1'";
          }
          {
            name = "*.md";
            run = ''piper -- CLICOLOR_FORCE=1 glow -w=$w -s=dark "$1"'';
          }
          {
            name = "*/";
            run = ''piper -- eza -TL=3 --color=always --icons=always --group-directories-first --no-quotes "$1"'';
          }
        ];
      };

      tasks = {
        image_alloc = 1073741824; # = 1024*1024*1024 = 1024MB
      };

      preview = {
        image_filter = "triangle";
        image_quality = 70;
        max_width = 800;
        max_height = 800;
      };

      mgr = {
        sort_dir_first = true;
        title_format = "{cwd}";
      };

      opener = {
        "video" = [
          {
            run = ''mpv "$@" >/dev/null 2>&1 &'';
            desc = "Play video";
            block = true;
            orphan = true;
          }
        ];
        "edit" = [
          {
            run = ''$EDITOR "$@"'';
            desc = "Edit";
            block = true;
          }
        ];
        "open" = [
          {
            run = ''xdg-open "$@"'';
            desc = "Open";
          }
        ];
        "image" = [
          {
            run = ''nomacs "$@"'';
            desc = "Open in nomacs";
            orphan = true;
          }
        ];
        "default_browser" = [
          {
            run = ''$BROWSER "$@"'';
            desc = "Open in default browser";
            orphan = true;
          }
        ];
        "librewolf" = [
          {
            run = ''librewolf "$@"'';
            desc = "Open in Librewolf";
            orphan = true;
          }
        ];
        "qutebrowser" = [
          {
            run = ''qutebrowser "$@"'';
            desc = "Open in qutebrowser";
            orphan = true;
          }
        ];
        "qbittorrent" = [
          {
            run = ''qbittorrent "$@"'';
            desc = "Open in qBittorrent";
            orphan = true;
          }
        ];
        "rtorrent" = [
          {
            run = ''cp "$@" $HOME/Downloads/rtorrent/watch && kitty --hold sh -c "rtorrent"'';
            desc = "Open in rtorrent";
            orphan = true;
          }
        ];
      };

      # check file mime type: xdg-mime query filetype [FILE]
      open.append_rules = [
        {
          mime = "image/*";
          use = ["image"];
        }
        {
          name = "*.ARW";
          use = "image";
        }
        {
          mime = "video/*";
          use = ["video"];
        }
        {
          name = "*.torrent";
          use = [
            "qbittorrent"
            "rtorrent"
          ];
        }
        {
          mime = "application/json";
          use = ["edit"];
        }
        {
          mime = "";
          use = ["edit"];
        }
        {
          mime = "text/html";
          use = [
            "default_browser"
            "librewolf"
            "qutebrowser"
            "edit"
          ];
        }
        {
          mime = "*";
          use = ["edit"];
        }
      ];
    }; # settings end

    theme = lib.mkForce {
      tabs = {
        active = {
          fg = "#${base00}";
          bg = "#${base0B}";
        };
        inactive = {
          fg = "#${base03}";
          bg = "#${base01}";
        };
        sep_inner = {
          open = "";
          close = "";
        };
        sep_outer = {
          open = "";
          close = "";
        };
      };

      mgr = {
        border_symbol = "│";
        border_style = {
          fg = "#${base01}";
        };

        count_copied = {
          fg = "#${base00}";
          bg = "#${base0B}";
        };
        count_cut = {
          fg = "#${base00}";
          bg = "#${base08}";
        };
        count_selected = {
          fg = "#${base00}";
          bg = "#${base0A}";
        };

        # Color block on the left side separator line in the filename.
        # marker_copied = {
        #   bg = "#${base0B}";
        #   fg = "#${base0B}";
        # };
        # marker_cut = {
        #   bg = "#${base0E}";
        #   fg = "#${base0E}";
        # };
        # marker_marked = { # SEL/V mode
        #   bg = "#${base0F}";
        #   fg = "#${base0F}";
        # };
        # marker_selected = {
        #   bg = "#${base0A}";
        #   fg = "#${base0A}";
        # };
      };

      mode = {
        normal_main = {
          fg = "#${base00}";
          bg = "#${base03}";
        };
        normal_alt = {
          # file size info, etc
          fg = "#${base04}";
          bg = "#${base01}";
        };
        select_main = {
          fg = "#${base00}";
          bg = "#${base0F}";
        };
        select_alt = {
          fg = "#${base04}";
          bg = "#${base01}";
        };
        unset_main = {
          fg = "#${base00}";
          bg = "#${base0E}";
        };
        unset_alt = {
          fg = "#${base04}";
          bg = "#${base01}";
        };
      };

      status = {
        sep_left = {
          open = "";
          close = "";
        };
        sep_right = {
          open = "";
          close = "";
        };
        overall = {
          fg = "#${base04}";
          bg = "#${base01}";
        };
      };

      icon = {
        prepend_dirs = [
          {
            name = "nix";
            text = "✼";
          }
          {
            name = "Music";
            text = "♫";
          }
          {
            name = "Downloads";
            text = "🢳";
          }
          {
            name = "Documents";
            text = "🗋";
          }
          {
            name = "Videos";
            text = "⏯";
          }
          {
            name = "Pictures";
            text = "";
          }
          {
            name = "home";
            text = "⌂";
          }
          {
            name = "Public";
            text = "⌾";
          }
        ];
      };
    };

    keymap = {
      mgr.prepend_keymap = [
        # copy to system clipboard
        {
          on = "<C-y>";
          run = [
            ''
              shell --interactive 'for path in "$@"; do echo "file://$path"; done | wl-copy -t text/uri-list'
            ''
          ];
        }
        {
          on = "<C-н>";
          run = [
            ''
              shell --interactive 'for path in "$@"; do echo "file://$path"; done | wl-copy -t text/uri-list'
            ''
          ];
        }
        # drag and drop
        {
          on = "<C-g>";
          run = ''
            shell --interactive '${pkgs.dragon-drop}/bin/dragon-drop -x -i -T "$1"'
          '';
        }
        {
          on = "<C-п>";
          run = ''
            shell --interactive '${pkgs.dragon-drop}/bin/dragon-drop -x -i -T "$1"'
          '';
        }
        # plugin mount
        {
          on = "<C-m>";
          run = "plugin mount";
          desc = "Mount partitions";
        }
        {
          on = "<C-ь>";
          run = "plugin mount";
          desc = "Mount partitions";
        }
        # plugin smart enter
        {
          on = "l";
          run = "plugin smart-enter";
          desc = "Enter the child directory, or open the file";
        }
        {
          on = "д";
          run = "plugin smart-enter";
          desc = "Enter the child directory, or open the file";
        }
        # plugin smart filter
        {
          on = "?";
          run = "plugin smart-filter";
          desc = "Smart filter";
        }
        # plugin compress
        {
          on = ["C"];
          run = "plugin ouch";
          desc = "Compress with ouch";
        }

        # plugin recycle-bin
        {
          on = ["b" "o"];
          run = "plugin recycle-bin -- open";
          desc = "Open trash";
        }
        {
          on = ["b" "e"];
          run = "plugin recycle-bin -- empty";
          desc = "Empty trash";
        }
        {
          on = ["b" "D"];
          run = "plugin recycle-bin -- emptyDays";
          desc = "Empty trash by [DAYS]";
        }
        {
          on = ["b" "d"];
          run = "plugin recycle-bin -- delete";
          desc = "Remove completely";
        }
        {
          on = ["b" "r"];
          run = "plugin recycle-bin -- restore";
          desc = "Restore";
        }

        # plugin convert imgs
        {
          on = ["c" "p"];
          run = "plugin convert -- --extension='png'";
          desc = "Convert to PNG";
        }
        {
          on = ["c" "j"];
          run = "plugin convert -- --extension='jpg'";
          desc = "Convert to JPG";
        }
        # other rus
        {
          on = "Р";
          run = "back";
          desc = "Back to previous directory";
        }
        {
          on = "Д";
          run = "forward";
          desc = "Forward to next directory";
        }

        {
          on = "р";
          run = "leave";
          desc = "Back to parent directory";
        }
        {
          on = "л";
          run = "arrow prev";
          desc = "Previous file";
        }
        {
          on = "о";
          run = "arrow next";
          desc = "Next file";
        }
        {
          on = "й";
          run = "quit";
          desc = "ru: quit";
        }
        {
          on = "м";
          run = "visual_mode";
          desc = "ru: visual mode enter";
        }
        {
          on = "н";
          run = "yank";
          desc = "ru: yank";
        }
        {
          on = "Н";
          run = "unyank";
          desc = "ru: unyank";
        }
        {
          on = "ч";
          run = "yank --cut";
          desc = "ru: cut";
        }
        {
          on = "Ч";
          run = "unyank";
          desc = "ru: uncut";
        }
        {
          on = "з";
          run = "paste";
          desc = "ru: paste";
        }
        {
          on = "в";
          run = "remove";
          desc = "ru: trash";
        }
        {
          on = "В";
          run = "remove --permanently";
          desc = "ru: delete";
        }
        {
          on = "е";
          run = "tab_create --current";
          desc = "Create a new tab with CWD";
        }
        {
          on = "ц";
          run = "tasks:show";
          desc = "Show task manager";
        }
      ];
    };
  };
}
