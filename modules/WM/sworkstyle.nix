{ lib
, pkgs
, ...
}:
let
  conf = ''
    fallback = '?'
    separator = ' '

    [matching]
    # top priority /\
    # low priority \/

    # by title
    '/^.* - cmus$/' = 'cmus'
    '/^man .*$/' = 'man'
    'org.telegram.desktop' = 'tg'
    'org.qutebrowser.qutebrowser' = 'qb'
    'org.qbittorrent.qBittorrent' = 'torrent'
    '/^.*[Ss]team.*$/' = 'steam'
    '/^vi.*$/' = 'vi'
    '/^.*Nvim$/' = 'vi'
    '/^nvim$/' = 'vi'
    '/^y .*$/' = 'y'

    # by app id
    'librewolf' = 'browser'
    'darktable' = 'darktable'
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
