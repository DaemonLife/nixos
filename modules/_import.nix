{ ... }: {
  imports = [
    ./git.nix
    ./jrnl.nix
    ./rtorrent.nix
    ./gowall.nix
    # ./qt.nix
    ./gtk.nix
    ./fzf.nix
    ./stylix.nix
    ./joplin.nix
    ./GIMP.nix
    ./nomacs.nix
    ./chess/cli-chess.nix
    # ./typer.nix
    ./tt.nix

    ./shell/_import.nix
    ./terminal/_import.nix
    ./editor/_import.nix
    ./file_manager/_import.nix
    ./WM/_import.nix

    ./player/_import.nix
    ./telegram/_import.nix
    ./browser/_import.nix
  ];
}
