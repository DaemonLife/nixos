{ pkgs
, lib
, config
, ...
}: {
  home.packages = with pkgs; [
    # libsForQt5.qt5.qtwayland
    # kdePackages.qtwayland
    # kdePackages.qt6ct
  ];
  qt = {
    enable = true;
    # style.name = lib.mkForce "adwaita";
  };
}
