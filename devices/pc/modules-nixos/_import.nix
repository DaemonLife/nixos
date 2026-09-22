{username, ...}: {
  imports = [
    # ./docker.nix
    ./zerotier.nix
    ./ollama.nix
  ];
}
