{
  pkgs,
  config,
  username,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules-nixos/_import.nix
  ];

  networking.hostName = lib.mkForce "lenovo";

  # --------------------------------
  # iGPU, pkgs, kernel
  # --------------------------------

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [mesa.opencl]; # OpenCL support using rusticl
    };
  };

  environment.systemPackages = with pkgs; [
    nvtopPackages.amd # nvtop - (h)top like task monitor for gpu
    clinfo # Print information about available OpenCL platforms and devices
    displaycal
    argyllcms # for displaycal
    # android-tools # adb, fastboot support
  ];

  # --------------------------------
  # HIBERNATION
  # --------------------------------

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16GB
    }
  ];

  services.udev.extraRules = ''
    ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x1483" ATTR{power/wakeup}="disabled"
  '';

  # --------------------------------
  # OTHER
  # --------------------------------

  system.stateVersion = "25.11";
  home-manager.users.${username} = {
    home.stateVersion = config.system.stateVersion;
  };
}
