# for home.nix
{ pkgs, lib, ... }: {

  # home.packages = with pkgs; [
  #   i3blocks-gaps
  # ];

  programs.i3blocks = {
    enable = true;
    bars = {
      top = {
        # The title block
        title = {
          interval = "persist";
          command = "xtitle -s";
        };
      };
      bottom = {
        time = {
          command = "date +%r";
          interval = 1;
        };
        # Make sure this block comes after the time block
        date = lib.hm.dag.entryAfter [ "time" ] {
          command = "date +%d";
          interval = 5;
        };
        # And this block after the example block
        example = lib.hm.dag.entryAfter [ "date" ] {
          command = "echo hi $(date +%s)";
          interval = 3;
        };
      };
    };
  };

  xsession.windowManager.i3 = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";

      fonts = {
        names = [ "UnifontExMono" ];
        # style = "Bold Semi-Condensed";
        size = 15.0;
      };

      bars = [
        {
          position = "bottom";
          # statusCommand = "i3status --config $HOME/.config/i3/i3status.conf";
          statusCommand = "i3blocks";
          fonts = {
            names = [ "UnifontExMono" ];
            # style = "Bold Semi-Condensed";
            size = 15.0;
          };
          colors = {
            background = "#000000";
            statusline = "#ffffff";
            separator = "#666666";
            # focusedWorkspace = [ "#4c7899" "#285577" "#ffffff" ];
            # activeWorkspace = [ "#333333" "#5f676a" "#ffffff" ];
            # inactiveWorkspace = [ "#333333" "#222222" "#888888" ];
            # urgentWorkspace = [ "#2f343a" "#900000" "#ffffff" ];
            # binding_mode = ["#2f343a" "#900000" "#ffffff"];
          };
          extraConfig = ''
            separator_symbol |
          '';
        }
      ];

      keybindings = {
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+Shift+r" = "reload";
        "${modifier}+Return" = "exec alacritty";
        "${modifier}+q" = "kill";
        "${modifier}+a" = "exec ${pkgs.dmenu}/bin/dmenu_run";
      };

      startup = [
        { command = "xiccd"; notification = true; }
        { command = "bluetooth off"; notification = true; }
        { command = "setxkbmap -layout us,ru -option grp:switch,grp:win_space_toggle"; notification = false; }
      ];

    };

    extraConfig = ''
      floating_modifier Mod4
      default_border pixel 4
      default_floating_border normal 2
      hide_edge_borders none
      focus_wrapping yes
      focus_follows_mouse yes
      focus_on_window_activation urgent
      mouse_warping output
      workspace_layout default
      workspace_auto_back_and_forth yes
      client.focused #7daea3 #7daea3 #202020 #e78a4e #7daea3
      client.focused_inactive #7daea3 #7daea3 #202020 #2a2827 #2a2827
      client.unfocused #2a2827 #2a2827 #ddc7a1 #2a2827 #2a2827
      client.urgent #2a2827 #2a2827 #ddc7a1 #2a2827 #2a2827
      client.placeholder #202020 #202020 #ddc7a1 #202020 #202020
      client.background #ffffff

      bindsym Ctrl+h exec brightnessctl set 5%-
      bindsym Ctrl+j exec bash $HOME/nix/scripts/volume.sh 5%+
      bindsym Ctrl+k exec bash $HOME/nix/scripts/volume.sh 5%-
      bindsym Ctrl+l exec brightnessctl set +5%
      bindsym F1 exec cmus-remote -r
      bindsym F10 exec swaymsg input 'type:keyboard' xkb_switch_layout 0 && exec swaylock
      bindsym F2 exec cmus-remote -u
      bindsym F3 exec cmus-remote -n
      # bindsym Mod4+0 workspace number 10
      # bindsym Mod4+1 workspace number 1
      # bindsym Mod4+2 workspace number 2
      # bindsym Mod4+3 workspace number 3
      # bindsym Mod4+4 workspace number 4
      # bindsym Mod4+5 workspace number 5
      # bindsym Mod4+6 workspace number 6
      # bindsym Mod4+7 workspace number 7
      # bindsym Mod4+8 workspace number 8
      # bindsym Mod4+9 workspace number 9
      # bindsym Mod4+Ctrl+0 move container to workspace number 10
      # bindsym Mod4+Ctrl+1 move container to workspace number 1
      # bindsym Mod4+Ctrl+2 move container to workspace number 2
      # bindsym Mod4+Ctrl+3 move container to workspace number 3
      # bindsym Mod4+Ctrl+4 move container to workspace number 4
      # bindsym Mod4+Ctrl+5 move container to workspace number 5
      # bindsym Mod4+Ctrl+6 move container to workspace number 6
      # bindsym Mod4+Ctrl+7 move container to workspace number 7
      # bindsym Mod4+Ctrl+8 move container to workspace number 8
      # bindsym Mod4+Ctrl+9 move container to workspace number 9
      bindsym Mod4+Ctrl+h move left
      bindsym Mod4+Ctrl+j move down
      bindsym Mod4+Ctrl+k move up
      bindsym Mod4+Ctrl+l move right

      bindsym Mod4+Shift+B exec export QT_WAYLAND_DISABLE_WINDOWDECORATION=0 && exec proxychains4 qutebrowser --desktop-file-name vpn_qutebrowser --set window.title_format "[VPN] {perc}{current_title}{title_sep}qutebrowser"
      bindsym Mod4+Shift+f floating toggle
      bindsym Mod4+Shift+j exec bash $HOME/nix/scripts/sway_workspace.sh next
      bindsym Mod4+Shift+k exec bash $HOME/nix/scripts/sway_workspace.sh prev
      bindsym Mod4+Shift+s exec bash $HOME/nix/scripts/screenshot.sh region
      bindsym Mod4+b exec export QT_WAYLAND_DISABLE_WINDOWDECORATION=0 && exec $BROWSER
      bindsym Mod4+t exec AyuGram || exec Telegram


      gaps inner 0
      gaps outer 0
      smart_borders on
      # exec bluetooth off
      # exec setxkbmap -layout us,ru -option grp:switch,grp:win_space_toggle
      # exec xiccd
      # exec_always --no-startup-id $HOME/nix/devices/lenovo/scripts/launch_polybar.sh

      workspace "1" output "eDP-1"
      workspace "2" output "eDP-1"
      workspace "3" output "DP-1" "DP-2" "HDMI-A-1"
      workspace "4" output "DP-1" "DP-2" "HDMI-A-1"
      workspace "5" output "DP-1" "DP-2" "HDMI-A-1"
      workspace "6" output "DP-1" "DP-2" "HDMI-A-1"
      workspace "7" output "DP-1" "DP-2" "HDMI-A-1"
      workspace "8" output "DP-1" "DP-2" "HDMI-A-1"
      workspace "9" output "DP-1" "DP-2" "HDMI-A-1"
      workspace "10" output "DP-1" "DP-2" "HDMI-A-1"
      popup_during_fullscreen smart
      floating_minimum_size 500 x 450
    '';
  };
}

