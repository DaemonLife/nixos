{...}: {
  imports = [
    ./librewolf/firefox.nix
    ./mpv.nix
    ./telegram-theme.nix
    ./git.nix
    ./cmus.nix
    ./jrnl.nix
    ./rtorrent.nix
    ./qutebrowser.nix
    ./gowall.nix
    ./qt.nix
    ./gtk.nix
    ./fzf.nix
    ./stylix.nix
    ./joplin-cli.nix
    ./GIMP.nix
    ./nchat.nix
    ./nomacs.nix

    # --- EDITOR ---
    # nvf acivated in flake.nix !!! # best!
    # ./nixvim.nix # hard
    # ./helix.nix # if you are lazy and use only qwerty layout

    # --- DESKTOP TILING MANAGER ---
    ./sway.nix # best bc color profiles!
    # ./niri.nix # can be best! no color profiles...
    # ./hyprland.nix # good dunamic tiling and windows moving

    # --- TERMINAL ---
    ./foot.nix # best! no errors with fonts
    # ./kitty.nix # it was good
    # ./alacritty.nix # fine but meh

    # --- TERMINAL FILE MANAGER ---
    ./yazi.nix # best!
    # ./lf/lf.nix # good
    # ./ranger.nix # meh

    # --- SHELL ---
    ./fish.nix # best?? autocomplite from man pages from time by time
    # ./zsh.nix

    # --- OTHER ---
    # ./eww/eww.nix # too hard meh
  ];
}
