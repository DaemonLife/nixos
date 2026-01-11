# for configuration.nix
{ ... }: {
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";
  users.users.user.extraGroups = [ "docker" ];
}

