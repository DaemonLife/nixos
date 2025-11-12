# Configuration for Lenovo
{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd # opencl
      ];
    };
    amdgpu = {
      opencl.enable = true; # OpenCL support using ROCM
      initrd.enable = true;
    };

  };
  boot.initrd.kernelModules = [ "amdgpu" ];


  environment.systemPackages = with pkgs; [
    ## Tools ##
    glxinfo # OpenGL info
    vulkan-tools # Khronos official Vulkan Tools and Utilities
    clinfo # Print information about available OpenCL platforms and devices
    libva-utils # Collection of utilities and examples for VA-API
    ## Monitor ##
    lact # Linux GPU Configuration Tool for AMD and NVIDIA
    amdgpu_top # Tool to display AMDGPU usage
    nvtopPackages.amd # (h)top like task monitor for AMD, Adreno, Intel and NVIDIA GPUs
  ];

  ## LACT daemon ##
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];


  # --------------------------------
  # HIBERNATION
  # --------------------------------

  # swap file
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16GB
    }
  ];
  # hibernation (swap file is necessary)
  boot.initrd.systemd.enable = true;
  # Specifies what to do when the laptop lid is closed
  # services.logind.lidSwitch = "suspend-then-hibernate";

  # --------------------------------
  # OTHER SERVICES
  # --------------------------------

  services = {
    # Battery life / TLP
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 100;

        CPU_BOOST_ON_AC = "1";
        CPU_BOOST_ON_BAT = "0";

        # Controls runtime power management for PCIe devices (Fan).
        PCIE_ASPM_ON_AC = "default";
        PCIE_ASPM_ON_BAT = "powersupersave";

        CONSERVATION_MODE = 1;
        TLP_DEFAULT_MODE = "conservation";

        # improve disk IO
        # DISK_IOSCHED = "";
      };
    }; # tlp
  }; # services

  system.stateVersion = "24.11";
}
