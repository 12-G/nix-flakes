{ pkgs, config, ... }:

{
  imports = [ ./hyprland.nix ];

  home.file = {
    ".config/wlogout" = {
      source = ./wlogout;
      recursive = true;
    };
    ".config/waybar" = {
      source = ./waybar;
      recursive = true;
    };
    ".config/mako" = {
      source = ./mako;
      recursive = true;
    };
    ".config/wofi" = {
      source = ./wofi;
      recursive = true;
    };
    ".config/wpaperd" = {
      source = ./wpaperd;
      recursive = true;
    };
    "/home/ethan/scripts" = {
      source = ./scripts;
      recursive = true;
    };
  };
}
