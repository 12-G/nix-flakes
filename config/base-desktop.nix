{ config, pkgs, flake, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # system-wide priviledges
  security.polkit = {
    enable = true;
    adminIdentities = [ "unix-user:ethan" ];
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
    configPackages = with pkgs; [ xdg-desktop-portal-hyprland ];
  };

  systemd = {
    user.services.polkit-mate-authentication-agent-1 = {
      description = "polkit-mate-authentication-agent-1";
      wantedBy = [ "hyprland-session.target" ];
      wants = [ "hyprland-session.target" ];
      after = [ "hyprland-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.mate.mate-polkit}/libexec/polkit-mate-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # For Nvidia GPU
  # hardware.nvidia = {
  #  package = config.boot.kernelPackages.nvidiaPackages.stable;
  #  modesetting.enable = true;
  #  open = false;
  #  powerManagement.enable = true;
  # };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  programs.firefox.enable = true;
  security.pam.services.swaylock = {};
  programs.light.enable = true;
  programs.dconf.enable = true;

  services = {
    gvfs.enable = true;
    tumbler.enable = true;
    xserver = {
      # Nvidia GPU
      videoDrivers = [ "nvidia" ];
      displayManager = {
        defaultSession = "hyprland";
        lightdm.enable = false;
        gdm = {
          enable = true;
          wayland = true;
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    curl
    linux-firmware
    gcc
    clang
    zig
    gdb
    p7zip
    unzip
    zip
    xdg-utils

    qq
    swaylock-effects
    swayidle

    mate.mate-polkit

    wttrbar
    wl-clipboard
    wf-recorder
    slurp
    libnotify
    imagemagick
    ffmpeg

    alsa-utils

    cinnamon.nemo
    cinnamon.nemo-fileroller

    python3
  ] ++ [
    config.nur.repos.xddxdd.rime-ice
  ];

  environment.sessionVariables = rec {
    # Java
    _JAVA_AWT_WM_NONREPARENTING = "1";

    # Nvidia
    # Hardware acceleration on NVIDIA GPUs
    #LIBVA_DRIVER_NAME = "nvidia";
    #GBM_BACKEND = "nvidia-drm";
    #__GLX_VENDOR_LIBRARY_NAME = "nvidia";

    # Toolkit Backend Variables
    CLUTTER_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";

    # QT Variables
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_QPA_PLATFORMTHEME = "qt5ct";

    NIXOS_OZONE_WL = "1";

    # Firefox
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_WEBRENDER = "1";

    # XDG Specifications
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_STATE_HOME = "$HOME/.local/state";

    # Wayalnd
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_EGL_NO_MODIFIRES = "1";
    WLR_RENDERER = "vulkan";

    # Other Software
    CARGO_HOME = "$XDG_CONFIG_HOME/cargo";
    nimbelDIR = "$XDG_CONFIG_HOME/nimble/.nimble";
    NPM_PATH = "$XDG_CONFIG_HOME/node_modules";
    NPM_BIN = "$XDG_CONFIG_HOME/node_modules/bin";
    NPM_CONFIG_PREFIX = "$XDG_CONFIG_HOME/node_modules";
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";
    TERMINAL = "kitty";

    # GTK
    GTK2_RC_FIELS = "$XDG_CONFIG_HOME/gtk-2.0/gtkrc";
    GNUPGHOME = "$XDG_DATA_HOME/gnupg";

    # fcitx5
    GLFW_IM_MODULE = "fcitx";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMDOIFIERS = "@im=fcitx";
    INPUT_METHOD = "fcitx";
    IMSETTINGS_MODULE = "fcitx";
  };
}
