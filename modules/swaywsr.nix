{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [swaywsr];

  home.activation.swaywsr_config = let
    config = ''
      [icons]

      [aliases]
      "Org.gnome.Nautilus" = "Nautilus"
      "kitty" = " "
      "org.telegram.desktop" = " "
      "librewolf" = " "

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
