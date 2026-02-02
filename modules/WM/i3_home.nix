# for home.nix
{ pkgs, lib, config, ... }:
let

  i3blocks_config = ''
    [window]
    command=xtitle -s
    interval=persist

    [layout]
    command=bash $HOME/nix/scripts/i3blocks/layout.sh
    interval=1

    [wifi]
    command=bash $HOME/nix/scripts/i3blocks/wifi.sh
    interval=5

    [volume-pipewire]
    command=bash $HOME/nix/scripts/i3blocks/volume.sh
    interval=1
    signal=1

    [battery]
    command=bash $HOME/nix/scripts/i3blocks/battery.sh
    interval=5

    [time]
    command=date "+%Y-%m-%d %H:%M"
    interval=5
  '';
in
{

  home.activation.i3blocks_config = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.config/i3blocks/; cd $HOME/.config/i3blocks/
    echo '${i3blocks_config}' > config
  '';

  # clipboard for x11
  home.packages = with pkgs; [
    brightnessctl
    feh
    envsubst
    pulseaudio
    i3blocks
    clipit
    xtitle
    acpi
    xss-lock
  ];
  programs.nixvim.clipboard.providers.xclip.enable = true;

  xsession.windowManager.i3 = with config.lib.stylix.colors; {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";

      fonts = {
        names = [ "UnifontExMono" ];
        size = lib.mkForce 20.0;
      };

      bars = [{
        position = "top";
        statusCommand = "i3blocks";
        fonts = {
          names = [ "${config.stylix.fonts.monospace.name}" ];
          size = lib.mkForce 20.0;
        };
        colors = {
          background = "#${base00}";
          statusline = "#${base06}";
          separator = "#${base03}";

          focusedWorkspace = {
            text = "#${base00}";
            background = "#${base0D}";
            border = "#${base0D}";
          };

          activeWorkspace = {
            text = "#${base00}";
            background = "#${base04}";
            border = "#${base04}";
          };

          urgentWorkspace = {
            text = "#${base00}";
            background = "#${base08}";
            border = "#${base08}";
          };
        };
        extraConfig = ''
          separator_symbol |
        '';
      }];

      keybindings = {
        "${modifier}+space" = "exec bash $HOME/nix/scripts/i3_layout_change.sh";
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+Shift+r" = "reload";
        "${modifier}+Return" = "exec --no-startup-id alacritty";
        "${modifier}+q" = "kill";
        "${modifier}+a" = "exec --no-startup-id ${pkgs.dmenu}/bin/dmenu_run -fn ' Unifont-20'";
        "${modifier}+Shift+l" = "exec --no-startup-id i3lock -c 000000";
        "${modifier}+f" = "fullscreen";
        "${modifier}+e" = "layout toggle splith splitv tabbed";
        "${modifier}+r" = "mode resize";
        "${modifier}+Shift+f" = "floating toggle";

        "${modifier}+Shift+j" = "workspace next";
        "${modifier}+Shift+k" = "workspace prev";

        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";

        "${modifier}+Ctrl+1" = "move container to workspace number 1";
        "${modifier}+Ctrl+2" = "move container to workspace number 2";
        "${modifier}+Ctrl+3" = "move container to workspace number 3";
        "${modifier}+Ctrl+4" = "move container to workspace number 4";
        "${modifier}+Ctrl+5" = "move container to workspace number 5";
        "${modifier}+Ctrl+6" = "move container to workspace number 6";
        "${modifier}+Ctrl+7" = "move container to workspace number 7";
        "${modifier}+Ctrl+8" = "move container to workspace number 8";
        "${modifier}+Ctrl+9" = "move container to workspace number 9";
        "${modifier}+Ctrl+0" = "move container to workspace number 10";

        "${modifier}+y" = "exec ${terminal} --hold -e $HOME/nix/scripts/y.fish";
      };

      startup = [
        { command = "xiccd"; notification = true; }
        { command = "clipit"; notification = true; }
        { command = "bluetooth off"; notification = true; }
        { command = "xrandr --output eDP-1 --auto --right-of DP-1"; notification = false; }
        { command = "feh --bg-scale $HOME/nix/images/image_good2.jpg"; notification = false; }
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
      bindsym F2 exec cmus-remote -u
      bindsym F3 exec cmus-remote -n
      bindsym Mod4+Ctrl+h move left
      bindsym Mod4+Ctrl+j move down
      bindsym Mod4+Ctrl+k move up
      bindsym Mod4+Ctrl+l move right

      bindsym Mod4+Shift+s exec bash $HOME/nix/scripts/screenshot.sh region
      bindsym Mod4+b exec export QT_WAYLAND_DISABLE_WINDOWDECORATION=0 && exec $BROWSER
      bindsym Mod4+t exec AyuGram || exec Telegram

      gaps inner 0
      gaps outer 0
      smart_borders on

      exec xset s 600 && xset dpms 0 0 0 && xss-lock -- i3lock -c 000000

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



