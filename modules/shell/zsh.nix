{ pkgs, config, lib, ... }: {

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    shellAliases = {
      # battery configuration will be restored at the next boot
      tlp_full = "sudo tlp fullcharge bat1";
      tlp_conserv = "sudo tlp setcharge bat1";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "web-search" "git" ];
    };

    # my theme for zsh + oh-my-zsh
    initExtra = ''
      source $HOME/nix/modules/zsh/themes/my.zsh-theme;
    '';
  };

  home.file."$HOME/nix/modules/zsh/themes/my.zsh-theme".text = ''
    PROMPT=$'
    %{$fg[blue]%}%/%{$reset_color%} $(git_prompt_info)$(bzr_prompt_info)%{$fg[white]%}[%n@%m]%{$reset_color%} %{$fg[white]%}[%T]%{$reset_color%}
    %{$fg_bold[white]%}>%{$reset_color%} '

    PROMPT2="%{$fg_bold[white]%}%_> %{$reset_color%}"

    GIT_CB="git::"
    ZSH_THEME_SCM_PROMPT_PREFIX="%{$fg[green]%}["
    ZSH_THEME_GIT_PROMPT_PREFIX=$ZSH_THEME_SCM_PROMPT_PREFIX$GIT_CB
    ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%} "
    ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
    ZSH_THEME_GIT_PROMPT_CLEAN=""
  '';

}
