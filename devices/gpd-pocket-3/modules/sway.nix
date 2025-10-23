{
  pkgs,
  config,
  lib,
  ...
}: {
  # disable gaps for gpd
  # and gpd output

  wayland.windowManager.sway = {
    config = rec {
      output = {
        # gpd laptop
        "DSI-1" = {
          mode = "1200x1920@60.000Hz";
          scale = "1.6"; # 1920 -> 1200px
          adaptive_sync = "on";
          render_bit_depth = "10"; # 6, 8, 10
          position = "0 0"; # main
          transform = "90";
        };
        # TV msk
        "Invalid Vendor Codename - RTK RTK TV 0x01010101" = {
          mode = "3840x2160@60.000Hz";
          scale = "1";
          adaptive_sync = "on";
          render_bit_depth = "10"; # 6, 8, 10
          position = "1200 0"; # to right from gpd
        };
      };

      workspaceOutputAssign = [
        {
          workspace = "1";
          output = "DSI-1";
        }
        {
          workspace = "2";
          output = "DSI-1";
        }
        {
          workspace = "3";
          output = "DSI-1";
        }
        {
          workspace = "4";
          output = "DSI-1";
        }
      ];
    };
  };
}
