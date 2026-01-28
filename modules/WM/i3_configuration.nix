# for configuration.nix
{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
  };
  services.displayManager.defaultSession = "none+i3";
  services.colord.enable = true;
  environment.systemPackages = with pkgs; [
    xiccd
  ];
}

