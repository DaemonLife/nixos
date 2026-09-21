{pkgs, ...}: {
  home.packages = with pkgs; [
    # dragon-drop
    # bat
    # eza
    # glow
    # ouch
    # mediainfo
    # imagemagick
    trash-cli
    # ffmpeg-full
  ];

  programs.nnn = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.unstable.nnn;
    # quitcd = true; # don not use it, bug
    # options = {};
  };
}
