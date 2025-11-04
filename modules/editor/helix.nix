{ pkgs, ... }: {

  home.packages = with pkgs; [
    # lang servers
    nil # nix
    bash-language-server

    # auto format servers 
    nixpkgs-fmt # nix
    # nixfmt-rfc-style # official nix format style
    shfmt # bash

    # other
    shellcheck # bash
    vscode-langservers-extracted # html
    marksman # markdown
    ruff # python
    pyright # python
    pylyzer # python
    uwu-colors
  ];

  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {

      editor = {
        # Show currently open buffers, only when more than one exists.
        bufferline = "multiple";
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        lsp.display-messages = true;

        gutters = {
          layout = [
            "line-numbers"
            "diagnostics"
            "diff"
          ];
          line-numbers.min-width = 1;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        indent-guides = {
          character = "┆";
          render = true;
          skip-levels = 1;
        };

        statusline = {
          left = [
            "mode"
            "spinner"
            "version-control"
            "file-name"
          ];
        };

        soft-wrap = {
          enable = true;
          max-wrap = 25; # increase value to reduce forced mid-word wrapping
          max-indent-retain = 0;
          wrap-indicator = ""; # hide it
        };

      }; # editor

      keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
        esc = [
          "collapse_selection"
          "keep_primary_selection"
        ];
        A-x = "extend_to_line_bounds";
        X = [
          "extend_line_up"
          "extend_to_line_bounds"
        ];
        C-right = "move_next_word_start";
        C-left = "move_prev_word_start";
        C-up = "move_visual_line_up";
        C-down = "move_visual_line_down";

        tab = "move_parent_node_end";
        S-tab = "move_parent_node_start";
        H = "extend_char_left";
        x = "extend_to_line_bounds";
        J = [
          "extend_line_down"
          "extend_to_line_bounds"
        ];
        K = [
          "extend_line_up"
          "extend_to_line_bounds"
        ];
        L = "extend_char_right";
        B = "extend_prev_word_start";
        W = "extend_next_word_start";
        E = "extend_next_word_end";
        g = {
          j = "goto_last_line";
          k = "goto_file_start";
        };

        # ------ rus layout
        # --- movement
        "р" = "move_char_left"; # h
        "о" = "move_visual_line_down"; # j
        "л" = "move_visual_line_up"; # k
        "д" = "move_char_right"; # l
        "ц" = "move_next_word_start"; # w
        "и" = "move_prev_word_start"; # b
        "у" = "move_next_word_end"; # e
        "Ц" = "move_next_long_word_start"; # W
        "И" = "move_prev_long_word_start"; # B
        "У" = "move_next_long_word_end"; # E
        "е" = "find_till_char"; # t
        "а" = "find_next_char"; # f
        "Е" = "till_prev_char"; # T
        "А" = "find_prev_char"; # F
        "П" = "goto_line"; # G
        "A-ю" = "repeat_last_motion"; # Alt-.
        "C-и" = "page_up"; # Ctrl-b, PageUp
        "C-а" = "page_down"; # Ctrl-f, PageDown
        "C-г" = "page_cursor_half_up"; # Ctrl-u
        "C-в" = "page_cursor_half_down"; # Ctrl-d
        "C-ш" = "jump_forward"; # Ctrl-i
        "C-о" = "jump_backward"; # Ctrl-o
        "C-ы" = "save_selection"; # Ctrl-s

        # --- changes
        "к" = "replace"; # r
        "К" = "replace_with_yanked"; # R
        "Ё" = "switch_case"; # ~
        "ё" = "switch_to_lowercase"; # `
        "A-ё" = "switch_to_uppercase"; # Alt-`
        "ш" = "insert_mode"; # i
        "ф" = "append_mode"; # a
        "Ш" = "insert_at_line_start"; # I
        "Ф" = "insert_at_line_end"; # A
        "щ" = "open_below"; # o
        "Щ" = "open_above"; # O
        # "." = "N/A"; # . - no setting...
        "г" = "undo"; # u
        "Г" = "redo"; # U
        "A-г" = "earlier"; # Alt-u
        "A-Г" = "later"; # Alt-U
        "н" = "yank"; # y
        "з" = "paste_after"; # p
        "З" = "paste_before"; # P
        # "Э<reg>" = "select_register"; # <reg> - skipped at this time
        "Ю" = "indent"; # >
        "Б" = "unindent"; # <
        "в" = "delete_selection"; # d
        "A-в" = "delete_selection_noyank"; # Alt-d
        "с" = "change_selection"; # c
        "A-с" = "change_selection_noyank"; # Alt-c
        "C-ф" = "increment"; # Ctrl-a
        "C-ч" = "decrement"; # Ctrl-x
        "Й" = "record_macro"; # Q
        "й" = "replay_macro"; # q

        # --- selection
        "ы" = "select_regex"; # s
        "Ы" = "split_selection"; # S
        "A-ы" = "split_selection_on_newline"; # Alt-s
        "ж" = "collapse_selection"; # ;
        "A-ж" = "flip_selections"; # Alt-;
        "A-Ж" = "ensure_selections_forward"; # Alt-:
        "б" = "keep_primary_selection"; # ,
        "A-б" = "remove_primary_selection"; # Alt-,
        "С" = "copy_selection_on_next_line"; # C
        "A-С" = "copy_selection_on_prev_line"; # Alt-C
        "ч" = "extend_line_below"; # x
        "Ч" = "extend_to_line_bounds"; # X
        "A-ч" = "shrink_to_line_bounds"; # Alt-x
        "О" = "join_selections"; # J
        "A-О" = "join_selections_space"; # Alt-J
        "Л" = "keep_selections"; # K
        "A-Л" = "remove_selections"; # Alt-K
        "C-с" = "toggle_comments"; # Ctrl-c
        "A-щ" = "expand_selection"; # Alt-o
        "A-ш" = "shrink_selection"; # Alt-i
        "A-з" = "select_prev_sibling"; # Alt-p
        "A-т" = "select_next_sibling"; # Alt-n
        "A-ф" = "select_all_siblings"; # Alt-a
        "A-Ш" = "select_all_children"; # Alt-I
        "A-у" = "move_parent_node_end"; # Alt-e
        "A-и" = "move_parent_node_start"; # Alt-b

        # --- search
        "." = "search"; # /
        "," = "rsearch"; # ?
        "т" = "search_next"; # n
        "Т" = "search_prev"; # N

        "м" = "select_mode"; # v
        # "g" = "N/A"; # g
        # "m" = "N/A"; # m
        "Ж" = "command_mode"; # :
        # "z" = "N/A"; # z
        # "Z" = "N/A"; # Z
        # "C-w" = "N/A"; # Ctrl-w

        # v = { # it works like key v + second key
        #   "я" = "align_view_center"; # z
        #   "с" = "align_view_center"; # c
        #   "е" = "align_view_top"; # t
        #   "и" = "align_view_bottom"; # b
        #   "ь" = "align_view_middle"; # m
        #   "о" = "scroll_down"; # j
        #   "л" = "scroll_up"; # k
        #   "C-а" = "page_down"; # Ctrl-f
        #   "C-и" = "page_up"; # Ctrl-b
        #   "C-г" = "page_cursor_half_up"; # Ctrl-u
        #   "C-в" = "page_cursor_half_down"; # Ctrl-d
        # };
        # g = {
        #   "п" = "goto_file_start"; # g
        #   "у" = "goto_last_line"; # e
        #   "а" = "goto_file"; # f
        #   "р" = "goto_line_start"; # h
        #   "д" = "goto_line_end"; # l
        #   "ы" = "goto_first_nonwhitespace"; # s
        #   "е" = "goto_window_top"; # t
        #   "с" = "goto_window_center"; # c
        #   "и" = "goto_window_bottom"; # b
        #   "в" = "goto_definition"; # d
        #   "н" = "goto_type_definition"; # y
        #   "к" = "goto_reference"; # r
        #   "ш" = "goto_implementation"; # i
        #   "ф" = "goto_last_accessed_file"; # a
        #   "ь" = "goto_last_modified_file"; # m
        #   "т" = "goto_next_buffer"; # n
        #   "з" = "goto_previous_buffer"; # p
        #   "ю" = "goto_last_modification"; # .
        #   "о" = "move_line_down"; # j
        #   "л" = "move_line_up"; # k
        #   "ц" = "goto_word"; # w
        # };

        "ь" = {
          "ь" = "match_brackets"; # m
          "ы" = "surround_add"; # s <char>
          "к" = "surround_replace"; # r <from><to>
          "в" = "surround_delete"; # d <char>
          "ф" = "select_textobject_around"; # a <object>
          "ш" = "select_textobject_inner"; # i <object>
        };

        space = {
          "с" = "toggle_comments";
        };

        # w = {
        #   "ц" = "rotate_view"; # w
        #   "C-ц" = "rotate_view"; # Ctrl-w
        #   "м" = "vsplit"; # v
        #   "C-м" = "vsplit"; # Ctrl-v
        #   "ы" = "hsplit"; # s
        #   "C-ы" = "hsplit"; # Ctrl-s
        #   "а" = "goto_file"; # f
        #   "А" = "goto_file"; # F
        #   "р" = "jump_view_left"; # h
        #   "C-р" = "jump_view_left"; # Ctrl-h
        #   # "Left" = "jump_view_left"; # Left
        #   "о" = "jump_view_down"; # j
        #   "C-о" = "jump_view_down"; # Ctrl-j
        #   # "Down" = "jump_view_down"; # Down
        #   "л" = "jump_view_up"; # k
        #   "C-л" = "jump_view_up"; # Ctrl-k
        #   # "Up" = "jump_view_up"; # Up
        #   "д" = "jump_view_right"; # l
        #   "C-д" = "jump_view_right"; # Ctrl-l
        #   # "Right" = "jump_view_right"; # Right
        #   "й" = "wclose"; # q
        #   "C-й" = "wclose"; # Ctrl-q
        #   "щ" = "wonly"; # o
        #   "C-щ" = "wonly"; # Ctrl-o
        #   "Р" = "swap_view_left"; # H
        #   "О" = "swap_view_down"; # J
        #   "Л" = "swap_view_up"; # K
        #   "Д" = "swap_view_right"; # L
        # };

        # s = {
        # };

        # p = {
        #   "C-г" = "scroll_up"; # Ctrl-u
        #   "C-в" = "scroll_down"; # Ctrl-d
        # };

        # u = {
        #   "ъв" = "goto_next_diag"; # ]d
        #   "хв" = "goto_prev_diag"; # [d
        #   "ъВ" = "goto_last_diag"; # ]D
        #   "хВ" = "goto_first_diag"; # [D
        #   "ъа" = "goto_next_function"; # ]f
        #   "ха" = "goto_prev_function"; # [f
        #   "ъе" = "goto_next_class"; # ]t
        #   "хе" = "goto_prev_class"; # [t
        #   "ъф" = "goto_next_parameter"; # ]a
        #   "хф" = "goto_prev_parameter"; # [a
        #   "ъс" = "goto_next_comment"; # ]c
        #   "хс" = "goto_prev_comment"; # [c
        #   "ъЕ" = "goto_next_test"; # ]T
        #   "хЕ" = "goto_prev_test"; # [T
        #   "ъз" = "goto_next_paragraph"; # ]p
        #   "хз" = "goto_prev_paragraph"; # [p
        #   "ъп" = "goto_next_change"; # ]g
        #   "хп" = "goto_prev_change"; # [g
        #   "ъП" = "goto_last_change"; # ]G
        #   "хП" = "goto_first_change"; # [G
        # };
      }; # keys.normal

      keys.insert = {
        # my setup
        C-right = "move_next_word_start";
        C-left = "move_prev_word_start";
        C-up = "move_visual_line_up";
        C-down = "move_visual_line_down";
        C-space = "completion";

        # rus
        "C-ы" = "commit_undo_checkpoint"; # Ctrl-s
        "C-ч" = "completion"; # Ctrl-x
        "C-к" = "insert_register"; # Ctrl-r
        "C-ц" = "delete_word_backward"; # Ctrl-w
        "A-в" = "delete_word_forward"; # Alt-d
        "C-г" = "kill_to_line_start"; # Ctrl-u
        "C-л" = "kill_to_line_end"; # Ctrl-k
        "C-р" = "delete_char_backward"; # Ctrl-h
        "C-в" = "delete_char_forward"; # Ctrl-d
        "C-о" = "insert_newline"; # Ctrl-j
      };

      keys.select = {
        tab = "extend_parent_node_end";
        S-tab = "extend_parent_node_start";

        g = {
          j = "goto_last_line";
          k = "goto_file_start";
        };

        "р" = "extend_char_left";
        "о" = "extend_visual_line_down";
        "л" = "extend_visual_line_up";
        "д" = "extend_char_right";

        # --- movement
        # "р" = "move_char_left"; # h
        # "о" = "move_visual_line_down"; # j
        # "л" = "move_visual_line_up"; # k
        # "д" = "move_char_right"; # l
        # "ц" = "move_next_word_start"; # w
        # "и" = "move_prev_word_start"; # b
        # "у" = "move_next_word_end"; # e
        # "Ц" = "move_next_long_word_start"; # W
        # "И" = "move_prev_long_word_start"; # B
        # "У" = "move_next_long_word_end"; # E
        # "е" = "find_till_char"; # t
        # "а" = "find_next_char"; # f
        # "Е" = "till_prev_char"; # T
        # "А" = "find_prev_char"; # F
        # "П" = "goto_line"; # G
        # "A-ю" = "repeat_last_motion"; # Alt-.
        # "C-и" = "page_up"; # Ctrl-b, PageUp
        # "C-а" = "page_down"; # Ctrl-f, PageDown
        # "C-г" = "page_cursor_half_up"; # Ctrl-u
        # "C-в" = "page_cursor_half_down"; # Ctrl-d
        # "C-ш" = "jump_forward"; # Ctrl-i
        # "C-о" = "jump_backward"; # Ctrl-o
        # "C-ы" = "save_selection"; # Ctrl-s

        # A-x = "extend_to_line_bounds";
        # X = [ "extend_line_up" "extend_to_line_bounds" ];
        # "A-ч" = "extend_to_line_bounds";
        # "Ч" = [ "extend_line_up" "extend_to_line_bounds" ];

        # "." = "global_search"; # /
        # "," = "command_palette"; # ?
      };
    }; # settings

    languages = {
      language-server.pyright.config.python.analysis.typeCheckingMode = "basic";
      language-server.ruff = {
        command = "ruff";
        args = [ "server" ];
      };

      language-server.pylyzer = {
        command = "pylyzer";
        args = [ "--server" ];
      };

      language = [
        {
          name = "nix";
          language-servers = [
            "nil"
            "uwu-colors"
          ];
          formatter.command = "nixpkgs-fmt";
          auto-format = true;
          indent = {
            tab-width = 2;
            unit = "	";
          };
        }
        {
          name = "python";
          language-servers = [
            "pyright"
            "ruff"
            "pylyzer"
            "uwu-colors"
          ];
          auto-format = true;
        }
        {
          name = "bash";
          language-servers = [
            "bash-language-server"
            "uwu-colors"
          ];
          auto-format = true;
          formatter = {
            command = "shfmt";
            args = [
              "-i"
              "2"
              "-"
            ];
          };
        }
        {
          name = "markdown";
          language-servers = [
            "marksman"
            "uwu-colors"
          ];
          auto-format = true;
          formatter = {
            command = "prettier";
            # args = [ "--stdin-filepath" "file.md" ];
          };
        }
        {
          name = "html";
          language-servers = [
            "vscode-html-language-server"
            "uwu-colors"
          ];
          auto-format = true;
          formatter.command = "prettier";
        }
        {
          name = "css";
          auto-format = true;
          language-servers = [
            "vscode-css-language-server"
            "uwu-colors"
          ];
        }
      ];
    };
  }; # programs
}
# main

