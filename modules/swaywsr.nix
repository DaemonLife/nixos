{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    swaywsr
    # font-awesome
  ];

  home.activation.swaywsr_config = let
    config = ''
      [icons]

      [aliases]
      "org.telegram.desktop" = "telegram"
      "librewolf" = "libwolf"
      "Org.gnome.Nautilus" = "nautilus"
      "kitty" = ">_"
      "qutebrowser" = "qb"
      "org.qbittorrent.qBittorrent" = "torrent"
      "vi" = "vi"

      [general]
      separator = " | "
      ignore-char = "#"

      [options]
      no-names = true
      remove-duplicates = true
    '';
  in
    lib.hm.dag.entryAfter ["writeBoundary"] ''
      mkdir -p "$HOME/.config/swaywsr"
      echo '${config}' > "$HOME/.config/swaywsr/config.toml"
    '';
}
