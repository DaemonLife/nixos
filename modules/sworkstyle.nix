{
  lib,
  pkgs,
  ...
}: let
  conf = ''
    fallback = '?'
    separator = '-'

    [matching]
    'org.telegram.desktop' = 'tg'
    'org.qutebrowser.qutebrowser' = 'qb'
    '/^vi.*$/' = 'vi'
    '/^.*Nvim$/' = 'vi'
    'foot' = '$'
    'yazi' = 'y'
    'tst' = 'tst'
  '';
in {
  home.packages = with pkgs; [swayest-workstyle];
  home.activation.sworkstyle_config = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run mkdir -p $HOME/.config/sworkstyle; \
      echo "${conf}" > $HOME/.config/sworkstyle/config.toml
  '';
}
