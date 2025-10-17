{lib, ...}: let
  config = ''
    [icons]
    # font awesome
    "librewolf" = ""
    Thunderbird = ""
    # smile emoji
    MyNiceProgram = "😛"

    [aliases]
    "Org.gnome.Nautilus" = "Nautilus"
    "kitty" = " "
    "org.telegram.desktop" = " "

    [general]
    seperator = ">"
    ignore-char = "#"

    [options]
    no-names = true
    remove-duplicates = true
  '';
in {
  home.activation.swaywsr_config = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run mkdir -p $HOME/.config/swaywsr/; \
      echo '${config}' > $HOME/.config/swaywsr/config.toml;
  '';
}
