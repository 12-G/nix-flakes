{ config, pkgs, myUserName, ... }:

{
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
  };

  # git
  programs.git = {
    enable = true;
    userName = "${myUserName}";
    userEmail = "1240121425@qq.com";
    diff-so-fancy.enable = true;
    extraConfig.init.defaultBranch = "main";
  };

  # gtk
  gtk = {
    enable = true;
    
    font = {
      name = "Roboto";
      package = pkgs.roboto;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "Catppuccin-Macchiato-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "compact";
        tweaks = [ "rimless" "black" ];
        variant = "macchiato";
      };
    };
  };

  # fish shell
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    loginShellInit = 
      if config.wayland.windowManager.hyprland.enable then ''
        set TTY1 (tty)
        [ "$TTY1" = "/dev/tty1" ] && exec Hyprland
      '' else '''';
    plugins = [
      {
        name = "fisher";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "fisher";
          rev = "2efd33ccd0777ece3f58895a093f32932bd377b6";
          sha256 = "sha256-e8gIaVbuUzTwKtuMPNXBT5STeddYqQegduWBtURLT3M=";
        };
      }

      {
        name = "tide";
        src = pkgs.fetchFromGitHub {
          owner = "ilancosman";
          repo = "tide";
          rev = "18d5fcfcfcbb79a56f4c4da1642084e5f41dfa65";
          sha256 = "sha256-cUHFbuH8rsDoZ1hsTtZ6c9kFdzQUkHg4bnnKmIUpy5E=";
        };
      }

      {
        name = "puffer-fish";
        src = pkgs.fetchFromGitHub {
          owner = "nickeb96";
          repo = "puffer-fish";
          rev = "5d3cb25e0d63356c3342fb3101810799bb651b64";
          sha256 = "sha256-aPxEHSXfiJJXosIm7b3Pd+yFnyz43W3GXyUB5BFAF54=";
        };
      }

      {
        name = "autopair.fish";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "4d1752ff5b39819ab58d7337c69220342e9de0e2";
          sha256 = "sha256-qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqZJ/oRIT1A=";
        };
      }

      {
        name = "fish";
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "fish";
          rev = "0ce27b518e8ead555dec34dd8be3df5bd75cff8e";
          sha256 = "sha256-Dc/zdxfzAUM5NX8PxzfljRbYvO9f9syuLO8yBr+R3qg=";
        };
      }

      {
        name = "fzf.fish";
        src = pkgs.fetchFromGitHub {
          owner = "patrickF1";
          repo = "fzf.fish";
          rev = "46c7bc6354494be5d869d56a24a46823a9fdded0";
          sha256 = "sha256-lxQZo6APemNjt2c21IL7+uY3YVs81nuaRUL7NDMcB6s=";
        };
      }
    ];
    shellAliases = {
      ga = "git add";
      gb = "git branch";
      gl = "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      gs = "git status";
      hypr = "Hyprland";
      ip = "ip --color=auto ad";
      l = "ls --color=auto -al --group-directories-first -I . -I ..";
      md = "mkdir";
      shutdown = "shutdown now";
      vi = "nvim";
      vim = "nvim";
    };
  };

  # wayland
  programs = {
    waybar = {
      enable = true;
      package = pkgs.waybar;
    };  
    wofi.enable = true;
    wpaperd.enable = true;
    wlogout.enable = true;
    kitty.enable = true;
  };
  services = {
    mako = {
      enable = true;
      actions = true;
    };
  };
  
  # allow fontconfig to discover fonts and configurations installed through home.packages.
  fonts.fontconfig.enable = true;
}