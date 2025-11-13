{ lib
, pkgs
, ...
}:
let
  conf = ''
    fallback = '?'
    separator = ' '

    [matching]
    '/^.* - cmus$/' = 'cmus'
    'org.telegram.desktop' = 'tg'
    'org.qutebrowser.qutebrowser' = 'qb'
    'org.qbittorrent.qBittorrent' = 'torrent'
    '/^.*[Ss]team.*$/' = 'steam'
    '/^vi.*$/' = 'vi'
    '/^.*Nvim$/' = 'vi'
    'darktable' = 'darktable'
    'yazi' = 'y'
    'foot' = '$'
  '';
in
{
  home.packages = with pkgs; [ swayest-workstyle ];
  home.activation.sworkstyle_config = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p $HOME/.config/sworkstyle; \
      echo "${conf}" > $HOME/.config/sworkstyle/config.toml
  '';
}
