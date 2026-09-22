{
  pkgs,
  lib,
  ...
}: {
  home.packages = [
    pkgs.unstable.cliamp
  ];
  xdg.configFile."cliamp/plugins/trash.lua" = {
    force = true;
    source = ./trash.lua;
  };
  xdg.configFile."cliamp/config.toml" = {
    force = true;
    source = ./config.toml;
  };
}
