{pkgs, ...}: {
  home.packages = with pkgs; [
    digikam
    # kdePackages.kdenlive # flatpak
    hugin
    siril
    unstable.rapidraw

    # games
    # bottles # flatpak is better for sundbox
    # lutris # flatpak?
  ];
}
