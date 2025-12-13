{ pkgs
, lib
, config
, inputs
, ...
}: {
  imports = [ ./modules/_import.nix ];

  home.packages = with pkgs; [
    # media
    unstable.digikam
    # blender
    unstable.darktable
    unstable.kdePackages.kdenlive

    # games
    bottles
  ];

  dconf.settings = {
    "org/gnome/desktop/peripherals/touchpad" = { speed = 0.8; };
  };

  # ==================
  #   kdeconnect 
  # ==================
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

}
