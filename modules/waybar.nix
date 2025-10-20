{
  config,
  lib,
  MY_DE,
  ...
}: {
  programs.waybar = with config.lib.stylix.colors;
    lib.mkForce {
      enable = true;

      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 28;
          modules-left = [
            "${MY_DE}/workspaces"
          ];
          modules-center = [
            # "${MY_DE}/window"
          ];
          modules-right = [
            "tray"
            "custom/sep"
            "${MY_DE}/language"
            "custom/sep"
            "network"
            "custom/sep"
            "bluetooth"
            "custom/sep"
            "idle_inhibitor"
            "custom/sep"
            "battery"
            "custom/sep"
            "pulseaudio"
            "custom/sep"
            "clock#date"
            "custom/sep"
            "clock#time"
          ];

          "${MY_DE}/workspaces" = {
            window-rewrite = {};
            on-click = "activate";
            disable-scroll = true;
            format = "{icon}";
            # persistent-workspaces = {
            #   # workspace and monitors
            #   "1" = [
            #     "eDP-1"
            #     "DSI-1"
            #   ];
            #   "2" = [
            #     "DP-1"
            #     "HDMI-A-1"
            #   ];
            #   "3" = [
            #     "DP-1"
            #     "HDMI-A-1"
            #   ];
            #   "4" = [
            #     "DP-1"
            #     "HDMI-A-1"
            #   ];
            #   "5" = [
            #     "DP-1"
            #     "HDMI-A-1"
            #   ];
            # };
            # format-icons = {
            #   "1" = 1; # workspace id and icon format
            #   "2" = 2;
            #   "3" = 3;
            #   "4" = 4;
            #   "5" = 5;
            #   "6" = 6;
            #   "7" = 7;
            #   "8" = 8;
            #   "9" = 9;
            #   "10" = 10;
            # };
          };

          "${MY_DE}/window" = {
            max-length = 60;
            separate-outputs = true;
            format = {};
            rewrite = {};
          };

          tray.spacing = 12;

          # Modules
          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "idle";
              deactivated = "idle";
            };
            tooltip = false;
          };

          "custom/sep" = {
            format = "|";
          };

          bluetooth = {
            format = "{icon}";
            format-alt = "{icon}";
            # interval = 5;
            format-icons = {
              enabled = "bt";
              disabled = "bt";
            };
            on-click = "bluetooth on";
            on-click-right = "bluetooth off";
            tooltip = false;
          };

          "${MY_DE}/language" = {
            format = "{}";
            format-en = "us";
            format-ru = "ru";
            tooltip = false;
          };

          "clock#time" = {
            format = "{:%H:%M}";
            tooltip = false;
            # exec = ../scripts/timezone.sh;
          };
          "clock#date" = {
            format = "{:%d-%b-%y}";
            on-click = "exec gnome-calendar";
            "tooltip-format" = "<span size='${toString (config.stylix.fonts.sizes.terminal - 2)}pt' font='${config.stylix.fonts.monospace.name}'>{calendar}</span>";
            "calendar" = {
              "mode" = "year";
              "mode-mon-col" = 4;
              # "weeks-pos"     = "right";
              "on-scroll" = 1;
              "on-click-right" = "mode";
              "format" = {
                "months" = "<span color='#${base0A}'>{}</span>";
                "days" = "<span color='#${base04}'>{}</span>";
                "weeks" = "<span color='#${base0C}'>W{}</span>";
                "weekdays" = "<span color='#${base0B}'>{}</span>";
                "today" = "<span color='#${base0E}'><b><u>{}</u></b></span>";
              };
            };
            "actions" = {
              "on-click-right" = "mode";
              "on-click-forward" = "tz_down";
              "on-click-backward" = "tz_up";
              "on-scroll-up" = "shift_down";
              "on-scroll-down" = "shift_up";
            };
          };

          battery = {
            states = {
              full = 98;
              good = 80;
              warning = 40;
              critical = 20;
            };
            # interval = 30;
            format = "bat {capacity}";
            format-plugged = "bat {capacity}";
            format-charging = "bat {capacity}ϟ";
            on-click = "gnome-power-statistics";
          };

          network = {
            format-disabled = "wifi";
            format-wifi = "wifi";
            format-ethernet = " {ipaddr}/{cidr}";
            format-linked = "wifi (No IP)";
            format-disconnected = "wifi";
            on-click = ''wifi on && $TERMINAL --hold sh -c "nmcli dev wifi rescan && nmtui"'';
            on-click-right = "wifi off";
            # interval = 2;
            tooltip = false;
          };

          pulseaudio = {
            # format = "{icon}{format_source}";
            format = "{icon} {volume}{format_source}";
            format-bluetooth = "{icon} {volume}{format_source}";
            format-bluetooth-muted = "{icon} {volume}{format_source}";
            format-muted = "muted";
            format-source = " mic";
            format-source-muted = "";
            format-icons = {
              hands-free = "headset";
              headset = "headset";
              headphone = "headset";
              phone = "phone";
              portable = "portable";
              car = "car";
              speaker = "speaker";
              default = "vol";
              hdmi = "hdmi";
            };
            max-volume = 100;
            tooltip-format = "{desc}, {volume}%";
            on-click = "$TERMINAL sh -c 'pulsemixer'"; # or pavucontrol
            on-click-right = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
            on-click-middle = "helvum";
            scroll-step = 5;
          };
        };
      };

      style = let
        focus =
          if "${MY_DE}" == "sway"
          then "focused"
          else "active";
      in
        #css
        ''
          	@define-color dark #${base00};
          	@define-color gray #${base02};
          	@define-color dark-white #${base04};
          	@define-color white #${base05};
          	@define-color accent #${base0D};
          	@define-color green #${base0B};
          	@define-color red #${base08};
          	@define-color magenta #${base09};
          	@define-color yellow #${base0A};

          	/* Default setting for all modules */
          	* {
          	  border: none;
              border-radius: 0;
              margin: 0px;
              text-decoration: none;
          	  font-family: "${config.stylix.fonts.monospace.name}";
              font-size: ${toString config.stylix.fonts.sizes.terminal}px;
              min-height: 0;
              box-shadow: none;
          	}

            /* Default color for modules except workspaces button.active */
            #workspaces button, #window, window#waybar, #tray, #language, #network, #bluetooth, #idle_inhibitor, #battery, #pulseaudio, #clock#time, #clock#date { color: @white; }

          	/* Default padding for some modules */
          #tray, #language, #network, #bluetooth, #idle_inhibitor, #battery, #pulseaudio, #clock { padding: 0px 8px 0px 8px; }

            #custom-sep {
              color: @gray;
            }

            #language {
              background-color: #${base00};
            }
            #network {
              background-color: #${base00};
            }
            #bluetooth {
              background-color: #${base00};
            }
            #idle_inhibitor {
              background-color: #${base00};
            }
            #pulseaudio {
              background-color: #${base00};
            }
            #battery {
              background-color: #${base00};
            }
            #clock.date {
              background-color: #${base00};
            }
            #clock.time {
              background-color: #${base00};
            }

            #workspaces button {
              font-weight: normal;
              padding: 0px 6px 0px 6px;
              margin: 0px 10px 0px 0px;
              background-color: #${base00};
            }
            #workspaces button.empty {
              font-weight: normal;
              color: @gray;
            }
            #workspaces button.${focus} {
              font-weight: normal;
              color: @dark;
              background-color: @accent;
            }

            window#waybar {
              background-color: @dark;
            }
            #window { padding: 0px 10px 0px 6px; }

            /* calendar look */
            tooltip {
              background-color: @dark;
              border: 4px;
              border-style: solid;
              border-color: @accent;
              font-size: 15px;
              font-weight: normal;
              margin: 0px 4px 0px 4px;
            }

            /* on but not connect */
          	#network.disconnected { color: @yellow;}
            /* off */
          	#network.disabled { color: @gray; }

          	#idle_inhibitor.activated { color: @green; }
          	#idle_inhibitor.deactivated { color: @gray; }

          	#bluetooth { color: @green; }
          	#bluetooth.disabled { color: @gray; }

          	#pulseaudio.muted { color: @gray; }

          	#battery.plugged { color: @green; }
          	#battery.charging{
              color: @green;
              animation-name: blink;
              animation-duration: 1.5s;
              animation-timing-function: linear;
              animation-iteration-count: infinite;
              animation-direction: alternate;
          	}
          	#battery.warning:not(.charging) { color: @yellow; }
          	#battery.critical:not(.charging) { color: @red; }
          	@keyframes blink { to { color: @gray; } }
        '';
    };
}
