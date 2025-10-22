{
  pkgs,
  config,
  lib,
  ...
}: {
  services.mako = with config.lib.stylix.colors; {
    settings = {
      # border-size = lib.mkForce 4;
    };
  };
}
