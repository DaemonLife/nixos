{ ... }: {

  programs.git = {
    enable = true;
    userName = "DaemonLife";

    aliases = {
      acp = ''!f() { git add .; git commit -m "$*"; git push && echo 'Push complited!'; }; f'';
    };
  };

}

# If you have flake.lock error with pull run:
# git reset HEAD -- flake.lock
# git restore -- flake.lock
