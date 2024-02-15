{ myUserName, config, pkgs, lib, flake, ... }:

{
  imports = [ 
    # inputs.hyprland.homeManagerModules.default

    ./home-config.nix
    ./general
    ./hypr
  ];

  home.username = "${myUserName}";
  home.homeDirectory = "/home/${myUserName}";

  programs.home-manager.enable = true;
}
