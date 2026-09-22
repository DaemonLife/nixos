{pkgs, ...}: {
  home.packages = [
    pkgs.unstable.cliamp
  ];
  xdg.configFile."cliamp/plugins/trash.lua".source = ./trash.lua;
  xdg.configFile."cliamp/config.toml".source = ./config.toml;
}
