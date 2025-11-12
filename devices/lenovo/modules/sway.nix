{
  pkgs,
  config,
  lib,
  ...
}: {
  # lenovo output, command: swaymsg -t get_outputs
  wayland.windowManager.sway = {
    config = rec {
      output = {
        # lenovo laptop
        "BOE 0x0931 Unknown" = let
          w = 2240;
          h = 1400;
          scale = 1.75;
          position_w = 2560;
          position_h = 380;
        in {
          mode = "${toString w}x${toString h}@60.002Hz";
          scale = "${toString scale}"; # 2240 -> 1400
          adaptive_sync = "true";
          render_bit_depth = "10"; # 6, 8, 10
          position = "${toString position_w} ${toString position_h}"; # laptop position for msk
          color_profile = "icc /home/user/nix/devices/screens/LEN140WUXGA+_2023-03-29.icm";
        };
        # monitor gg
        "Acer Technologies Acer A231H LQT0W0084320" = {
          mode = "1920x1080@60Hz";
          # scale = "1";
          scale_filter = "linear";
          # adaptive_sync = "enable";
          render_bit_depth = "10"; # 6, 8, 10
          position = "3840 0";
        };
        # monitor msk
        "Shenzhen KTC Technology Group H27S17 0x00000001" = let
          w = 2560;
          h = 1440;
          scale = 1.25;
        in {
          mode = "${toString w}x${toString h}@164.998Hz";
          scale = "${toString scale}";
          scale_filter = "smart";
          adaptive_sync = "true"; # always off at monitor (but there is too...?)
          render_bit_depth = "10"; # 6, 8, 10. Maybe flickings bc of 10 and 165Hz
          position = "512 0"; # left position
          color_profile = "icc /home/user/nix/devices/screens/H27S17_2024-06-16.icm";
        };
      };

      input = {
        "type:touchpad" = lib.mkForce {
          drag = "disabled";
          drag_lock = "disabled";
          natural_scroll = "enabled"; # enabled is good for lenovo
          tap = "enabled";
          click_method = "button_areas";
        };
      };

      workspaceOutputAssign = [
        {
          workspace = "1";
          output = "eDP-1";
        }
        {
          workspace = "2";
          output = ["DP-1" "HDMI-A-1"];
        }
        {
          workspace = "3";
          output = ["DP-1" "HDMI-A-1"];
        }
        {
          workspace = "4";
          output = ["DP-1" "HDMI-A-1"];
        }
        {
          workspace = "5";
          output = ["DP-1" "HDMI-A-1"];
        }
      ];
    }; # config
  };
}
