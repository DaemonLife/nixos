{ pkgs, lib, config, ... }: {

  home.packages = with pkgs; [ ];

  # QT STUFF WORKS DON'T TOUCH IT
  qt = {
    enable = true;
  };

}
