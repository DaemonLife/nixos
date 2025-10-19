{
  config,
  pkgs,
  ...
}: {
  programs.nvf = {
    enable = true;
    defaultEditor = true;
    # enableManpages = true; # man 5 nvf. ERROR with old pkg prettier/prettierd!

    settings.vim = {
      options = {
        shiftwidth = 2;
        tabstop = 4;
      };

      lsp = {
        formatOnSave = true;
        enable = true;
      };

      languages = {
        enableTreesitter = true;
        enableExtraDiagnostics = true;
        enableFormat = true;
        nix.enable = true;
        bash.enable = true;
        markdown.enable = true;
        python.enable = true;
      };

      autocomplete = {
        enableSharedCmpSources = true;
        blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
        };
      };

      visuals.indent-blankline = {
        enable = true;
        setupOpts.indent.char = "┆";
      };
      visuals.nvim-scrollbar.enable = true;

      ui = {
        borders.enable = true; # testing
        colorizer.enable = false;
        # fastaction.enable = true;
        #illuminate.enable = true;
        smartcolumn.enable = false;
      };

      diagnostics = {
        enable = true;
        nvim-lint.enable = true;
      };

      autopairs.nvim-autopairs.enable = true;
      notify.nvim-notify.enable = true;

      binds = {
        cheatsheet.enable = true;
        whichKey.enable = true;
      };

      mini.comment.enable = true;

      utility = {
        # multicursors.enable = true;
        nvim-biscuits.enable = true;
        nvim-biscuits.setupOpts = {
          cursor_line_only = true;
        };
      };

      lazy.plugins = {
        "zen-mode.nvim" = {
          package = pkgs.vimPlugins.zen-mode-nvim;
          setupModule = "zen-mode";
          cmd = ["ZenMode"];
          lazy = true;
          setupOpts = {
            window = {
              backdrop = 1; # disable shadow
              width = 80; # max line lenght
            };
          };
        };
      };

      keymaps = [
        # disable space
        {
          action = "";
          key = "<space>";
          mode = ["n" "v"];
        }
        {
          action = "";
          key = "<D-Space>";
          mode = "i";
        }

        # --- new redo ---
        {
          action = "<cmd>redo<CR><CR>";
          key = "U";
          mode = ["n" "v"];
        }
        {
          action = "";
          key = "<C-r>";
          mode = ["n" "v" "i"];
        }
        # --- new redo ---

        # --- new clipboard control ---
        {
          action = ''"+yl'';
          key = "<space>y";
          mode = ["n" "v"];
          desc = "Save to system slipboard";
        }
        {
          action = ''"+pl'';
          key = "<space>p";
          mode = ["n" "v"];
          desc = "Paste from system slipboard";
        }
        {
          action = ''"+dl'';
          key = "<space>d";
          mode = ["n" "v"];
          desc = "Cut to system slipboard";
        }
        # --- new clipboard control ---

        # --- new comment control ---
        # {
        #   action = "gcc";
        #   key = "<space>c";
        #   # mode = "n";
        #   mode = ["n" "v"];
        #   noremap = false;
        #   silent = true;
        # }
        # {
        #   action = "gc";
        #   key = "<space>c";
        #   # mode = "v";
        #   mode = ["n" "v"];
        #   noremap = false;
        #   silent = true;
        # }
        # --- new comment control ---

        # --- soft string jumping ---
        {
          action = "gj";
          key = "j";
          mode = ["n" "v"];
        }
        {
          action = "gk";
          key = "k";
          mode = ["n" "v"];
        }
        # --- soft string jumping ---

        # --- rus layout support ---
        {
          action = "q";
          key = "й";
          mode = ["n" "v"];
        }
        {
          action = "Q";
          key = "Й";
          mode = ["n" "v"];
        }
        {
          action = "w";
          key = "ц";
          mode = ["n" "v"];
        }
        {
          action = "W";
          key = "Ц";
          mode = ["n" "v"];
        }
        {
          action = "e";
          key = "у";
          mode = ["n" "v"];
        }
        {
          action = "E";
          key = "У";
          mode = ["n" "v"];
        }
        {
          action = "r";
          key = "к";
          mode = ["n" "v"];
        }
        {
          action = "R";
          key = "К";
          mode = ["n" "v"];
        }
        {
          action = "t";
          key = "е";
          mode = ["n" "v"];
        }
        {
          action = "T";
          key = "Е";
          mode = ["n" "v"];
        }
        {
          action = "y";
          key = "н";
          mode = ["n" "v"];
        }
        {
          action = "Y";
          key = "Н";
          mode = ["n" "v"];
        }
        {
          action = "u";
          key = "г";
          mode = ["n" "v"];
        }
        {
          action = "U";
          key = "Г";
          mode = ["n" "v"];
        }
        {
          action = "i";
          key = "ш";
          mode = ["n" "v"];
        }
        {
          action = "I";
          key = "Ш";
          mode = ["n" "v"];
        }
        {
          action = "o";
          key = "щ";
          mode = ["n" "v"];
        }
        {
          action = "O";
          key = "Щ";
          mode = ["n" "v"];
        }
        {
          action = "p";
          key = "з";
          mode = ["n" "v"];
        }
        {
          action = "P";
          key = "З";
          mode = ["n" "v"];
        }
        {
          action = "[";
          key = "х";
          mode = ["n" "v"];
        }
        {
          action = "{";
          key = "Х";
          mode = ["n" "v"];
        }
        {
          action = "a";
          key = "ф";
          mode = ["n" "v"];
        }
        {
          action = "A";
          key = "Ф";
          mode = ["n" "v"];
        }
        {
          action = "s";
          key = "ы";
          mode = ["n" "v"];
        }
        {
          action = "S";
          key = "Ы";
          mode = ["n" "v"];
        }
        {
          action = "d";
          key = "в";
          mode = ["n" "v"];
        }
        {
          action = "D";
          key = "В";
          mode = ["n" "v"];
        }
        {
          action = "f";
          key = "а";
          mode = ["n" "v"];
        }
        {
          action = "F";
          key = "А";
          mode = ["n" "v"];
        }
        {
          action = "g";
          key = "п";
          mode = ["n" "v"];
        }
        {
          action = "G";
          key = "П";
          mode = ["n" "v"];
        }
        {
          action = "h";
          key = "р";
          mode = ["n" "v"];
        }
        {
          action = "H";
          key = "Р";
          mode = ["n" "v"];
        }
        {
          action = "gj";
          key = "о";
          mode = ["n" "v"];
        }
        {
          action = "J";
          key = "О";
          mode = ["n" "v"];
        }
        {
          action = "gk";
          key = "л";
          mode = ["n" "v"];
        }
        {
          action = "K";
          key = "Л";
          mode = ["n" "v"];
        }
        {
          action = "l";
          key = "д";
          mode = ["n" "v"];
        }
        {
          action = "L";
          key = "Д";
          mode = ["n" "v"];
        }
        {
          action = ";";
          key = "ж";
          mode = ["n" "v"];
        }
        {
          action = ":";
          key = "Ж";
          mode = ["n" "v"];
        }
        {
          action = "z";
          key = "я";
          mode = ["n" "v"];
        }
        {
          action = "Z";
          key = "Я";
          mode = ["n" "v"];
        }
        {
          action = "x";
          key = "ч";
          mode = ["n" "v"];
        }
        {
          action = "X";
          key = "Ч";
          mode = ["n" "v"];
        }
        {
          action = "c";
          key = "с";
          mode = ["n" "v"];
        }
        {
          action = "C";
          key = "С";
          mode = ["n" "v"];
        }
        {
          action = "v";
          key = "м";
          mode = ["n" "v"];
        }
        {
          action = "V";
          key = "М";
          mode = ["n" "v"];
        }
        {
          action = "b";
          key = "и";
          mode = ["n" "v"];
        }
        {
          action = "B";
          key = "И";
          mode = ["n" "v"];
        }
        {
          action = "n";
          key = "т";
          mode = ["n" "v"];
        }
        {
          action = "N";
          key = "Т";
          mode = ["n" "v"];
        }
        {
          action = "m";
          key = "ь";
          mode = ["n" "v"];
        }
        {
          action = "M";
          key = "Ь";
          mode = ["n" "v"];
        }
        {
          action = ",";
          key = "б";
          mode = ["n" "v"];
        }
        {
          action = "<";
          key = "Б";
          mode = ["n" "v"];
        }
        {
          action = ".";
          key = "ю";
          mode = ["n" "v"];
        }
        {
          action = ">";
          key = "Ю";
          mode = ["n" "v"];
        }
        {
          action = "/";
          key = "я";
          mode = ["n" "v"];
        }
        {
          action = "?";
          key = "Я";
          mode = ["n" "v"];
        }
        # --- rus layout support ---
      ];
    };
  };
}
