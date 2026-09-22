{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    (import ./waybar.nix {
      inherit config lib;
      MY_DE = "mangowm";
    })
    ./mako.nix
    ./fuzzel.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    grim # screenshot
    slurp # area for screenshot
    wl-clipboard # wayland clipboard
    wl-clip-persist # persist wayland clipboard
    xrandr # for setting x11 primary monitor
    wlr-randr # ls monitors
  ];
}
