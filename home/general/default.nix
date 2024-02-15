{ ... }:

{
  imports = [ ./fcitx5 ];
  home.file.".config/nvim" = {
    source = ./nvim;
    recursive = true;
  };

  home.file.".config/kitty" = {
    source = ./kitty;
    recursive = true;
  };

  home.file."Pictures/wallpapers" = {
    source = ./wallpapers;
    recursive = true;
  };
}
