{pkgs, ...}: {
  nixpkgs.config.rocmSupport = true;
  # I want ROCm support for just ollama and darktable
  environment.systemPackages = [
    pkgs.pkgsRocm.ollama
    pkgs.pkgsRocm.darktable
    pkgs.pkgsRocm.ffmpeg-full
    # … non-GPU packages accessed normally
    #pkgs.nurl
  ];
}
