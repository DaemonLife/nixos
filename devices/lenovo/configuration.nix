# Configuration for Lenovo
{pkgs, ...}: {
  imports = [./hardware-configuration.nix];

  hardware = {
    graphics = {
      # radv driver an open-source Vulkan driver from freedesktop
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver # can be remove ?
        intel-ocl # openCL for all CPU (amd too)
        rocmPackages.clr.icd # opencl
      ];
    };
    amdgpu = {
      amdvlk = {
        # Warning: AMDVLK is being discontinued
        # amdvlk driver an open-source Vulkan driver from AMD
        # In the presence of both drivers, Steam will default to amdvlk. The amdvlk driver can be considered more correct regarding Vulkan specification implementation, but less performant than radv. However, this tradeoff between correctness and performance can sometimes make or break the gaming experience.
        # To "reset" your driver to radv set either AMD_VULKAN_ICD = "RADV"
        enable = false;
        support32Bit.enable = false;
      };
      opencl.enable = true; # OpenCL support using ROCM
    };
  };
  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];

  # enable HIP
  systemd.tmpfiles.rules = ["L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"];

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
