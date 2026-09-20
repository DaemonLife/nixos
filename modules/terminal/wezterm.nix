{
  config,
  lib,
  ...
}: {
  programs.wezterm = {
    enable = true;
    settings = {
      hide_tab_bar_if_only_one_tab = true;
      window_padding = {
        left = 0;
        right = 0;
        top = 0;
        bottom = 0;
      };
    };
  };
}
