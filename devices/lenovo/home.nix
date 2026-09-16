{pkgs, ...}: {
  home.packages = with pkgs; [
    digikam
    # unstable.darktable # flatpak is faster
    # kdePackages.kdenlive # flatpak
    hugin
    siril
  ];

  dconf.settings = {
    "org/gnome/desktop/peripherals/touchpad" = {speed = 0.8;};
  };
}
