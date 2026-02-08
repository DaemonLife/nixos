# for configuration.nix
{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
  };
  services.displayManager.defaultSession = "none+i3";

  # x11 color manager
  services.colord.enable = true;
  environment.systemPackages = with pkgs; [ xiccd ];

}

