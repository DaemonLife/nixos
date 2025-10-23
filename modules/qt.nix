{pkgs, ...}: {
  home.packages = with pkgs; [
    kdePackages.qtwayland
  ];
  qt = {
    enable = true;
  };
}
