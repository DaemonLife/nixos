{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [libnotify];

  # notify-send "Test messange from shell"
  services.mako = with config.lib.stylix.colors; {
    enable = true;
    settings = {
      layer = "overlay";
      anchor = "top-right";
      width = 400;
      icons = true;
      margin = "4,4,4,4";
      padding = "12,10,12,10";
      border-size = 2; # like Sway's border / 2
      border-radius = 0;
      default-timeout = 12000;
      group-by = "summary";
      # format = "<b>%s</b>\\n%b";
      format = "<b>%a</b>\n%s%b";
      "[mode=dnd]" = {invisible = 1;}; # dont works
    };
  };
}
