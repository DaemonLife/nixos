#!/usr/bin/env bash
set -euo pipefail
DEVICE=$1
REBUILD=$2
shift 2

cd $HOME/nix
git add -A
cd -

if [ "$REBUILD" != "test" ]; then
  command="nix flake update --flake $HOME/nix"
  printf "\n * Run %s\n" "$command"
  eval $command
fi

command="sudo nixos-rebuild --flake $HOME/nix/.\#$DEVICE $REBUILD $*"
printf "\n * Run %s\n" "$command"
eval $command
