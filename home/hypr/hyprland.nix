{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      monitor = , highres, auto, 1

      # Keybinding
      $mainMod = SUPER
      $scriptDir = ~/scripts
      $volume = $scriptDir/volume
      $backlight = $scriptDir/brightness
      $screenshot = $scriptDir/screenshot
      $lock = $scriptDir/lockscreen
      $app_launcher = $scriptDir/menu
      $logout = $scriptDir/logout
      $term = kitty
      $file = nemo
      $browser = firefox
      
      # Startup
      # exec-once = /usr/lib/mate-polkit
      exec-once = $scriptDir/hyprland
      exec-once = udiskie &
      exec-once = wpaperd &
      exec-once = fcitx5    # start fcitx5 daemon
      exec-once = mpd & waybar & mako &
      
      # Lock screen automatically
      exec-once = swayidle -w timeout 300 '$lock' timeout 330 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' before-sleep 'playerctl pause' before-sleep '$lock'
      
      # Sets Xwayland scale
      # exec-once = xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2
      # exec-once = xrdb -merge ~/.Xresources
      
      # Configure mouse and touchpad here.
      input {
          repeat_rate = 30
          repeat_delay = 240
          kb_layout = us
          follow_mouse = 1
          mouse_refocus = true
          numlock_by_default = true
      
          touchpad {
              natural_scroll = true
          }
      
          sensitivity = 0
      }
      
      # General settings like MOD key, Gaps, Colors, etc.
      general {
          gaps_in = 5
          gaps_out = 8
          border_size = 4
      
          col.active_border=0xFFB4A1DB
          col.inactive_border=0xFF343A40
      
          layout = master
      }
      
      # Dwindle Layout
      #dwindle {
      #    no_gaps_when_only = false
      #    force_split = 0
      #    special_scale_factor = 0.8
      #    split_width_multiplier = 1.0
      #    use_active_for_splits = true
      #    pseudotile = yes
      #    preserve_split = yes
      #}
      
      # Master Layout
      master {
          new_is_master = true
          special_scale_factor = 0.8
          no_gaps_when_only = false
      }
      
      # Decoration settings like Rounded Corners, Opacity, Blur, etc.
      decoration {
          active_opacity = 1.0
          inactive_opacity = 0.8
          fullscreen_opacity = 1.0
          rounding = 6
      
          blur {
              enabled = true
              size = 3
              passes = 1
              new_optimizations = 1
              xray = true
              ignore_opacity = false
          }
      
          drop_shadow = false
          shadow_range = 4
          shadow_render_power = 3
          shadow_ignore_window = true
          dim_inactive = false
          # dim_strength = #0.0 ~ 1.0
          col.shadow = rgba(1a1a1aee)
      }
      
      # Animation
      animations {
          enabled=1
          bezier = overshot, 0.13, 0.99, 0.29, 1.1
          animation = windows, 1, 4, overshot, slide
          animation = windowsOut, 1, 5, default, popin 80%
          animation = border, 1, 5, default
          animation = fade, 1, 8, default
          animation = workspaces, 1, 6, overshot, slidevert
      }
      
      # Misc
      misc {
          disable_autoreload = true
          disable_hyprland_logo = true
          always_follow_on_dnd = true
          layers_hog_keyboard_focus = true
          animate_manual_resizes = false
          enable_swallow = true
          swallow_regex =
          focus_on_activate = true
          mouse_move_enables_dpms = true
          key_press_enables_dpms = true
      }
      
      # Window Rules
      windowrule=float,foot-float
      windowrule=float,yad|nm-connection-editor|pavucontrolk
      windowrule=float,xfce-polkit|kvantummanager|qt5ct
      windowrule=float,feh|imv|Gpicview|Gimp|nomacs
      windowrule=workspace 8,title:^(qqmusic)
      
      windowrule=float,foot-full
      windowrule=move 0 0,foot-full
      windowrule=size 100% 100%,foot-full
      
      windowrule=float,wlogout
      windowrule=move 0 0,wlogout
      windowrule=size 100% 100%,wlogout
      windowrule=animation slide,wlogout
      
      windowrulev2=move 0 0,title:^(flameshot)
      windowrulev2=nofullscreenrequest,title:^(flameshot)
      
      # Hyprland relative
      bind = $mainMod, Q, killactive,
      bind = $mainMod, M, exit,
      bind = $mainMod + SHIFT, F, fullscreen,
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, S, pseudo, # dwindle
      # bind = $mainMod, J, togglesplit, # dwindle
      bind = $mainMod, X, exec, $logout
      bind = $mainMod + SHIFT, L, exec, $lock
      
      # Lanuch programs
      bind = SHIFT, RETURN, exec, $term
      bind = $mainMod, F, exec, $browser
      bind = $mainMod, W, exec, $app_launcher
      bind = $mainMod, E, exec, $file
      bind = $mainMod, N, exec, nm-connection-editor # networkmanager
      bind = ALT, M, exec, [workspace 8] qqmusic
      
      # Screenshots
      bind = ,Print,exec,$screenshot --now
      bind = SUPER,Print,exec,$screenshot --win
      # bind = CTRL + SHIFT, P, exec, $screenshot --area
      bind = CTRL + SHIFT, P, exec, grimblast --notify copy area
      
      # Backlight control
      bind=,XF86MonBrightnessUp,exec,$backlight --inc
      bind=,XF86MonBrightnessDown,exec,$backlight --dec
      bind = ALT, B, submap, backlight
      submap = backlight
      bind = , K, exec, $backlight --inc
      bind = , J, exec, $backlight --dec
      bind = , escape, submap, reset
      submap = reset
      
      # Volume control
      bind=,XF86AudioRaiseVolume,exec,$volume --inc
      bind=,XF86AudioLowerVolume,exec,$volume --dec
      bind=,XF86AudioMute,exec,$volume --toggle
      bind=,XF86AudioMicMute,exec,$volume --toggle-mic
      bind = ALT, V, submap, volume
      submap = volume
      bind = , K, exec, $volume --inc
      bind = , J, exec, $volume --dec
      bind = , 0, exec, $volume --toggle
      bind = , 9, exec, $voume --toggle-mic
      bind = , escape, submap, reset
      submap = reset
      
      # Play songs
      bind=,XF86AudioNext,exec,mpc next
      bind=,XF86AudioPrev,exec,mpc prev
      bind=,XF86AudioPlay,exec,mpc toggle
      bind=,XF86AudioStop,exec,mpc stop
      
      # Move focus with mainMod + {h,j,k,l}
      bind = $mainMod, H, movefocus, l
      bind = $mainMod, L, movefocus, r
      bind = $mainMod, K, movefocus, u
      bind = $mainMod, J, movefocus, d
      
      # Move windows with CTRL + SHIFT + {h,j,k,l}
      bind = CTRL + SHIFT, H, movewindow, l
      bind = CTRL + SHIFT, L, movewindow, r
      bind = CTRL + SHIFT, K, movewindow, u
      bind = CTRL + SHIFT, J, movewindow, d
      
      # Resize windows with SUPERCTRL + {h,j,k,l}
      bind = SUPERCTRL, L, resizeactive, 70 0
      bind = SUPERCTRL, H, resizeactive, -70 0
      bind = SUPERCTRL, K, resizeactive, 0 -70
      bind = SUPERCTRL, J, resizeactive, 0 70
      
      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10
      
      # Move active window to a workspace with ALT + [0-9]
      bind = ALT, 1, movetoworkspace, 1
      bind = ALT, 2, movetoworkspace, 2
      bind = ALT, 3, movetoworkspace, 3
      bind = ALT, 4, movetoworkspace, 4
      bind = ALT, 5, movetoworkspace, 5
      bind = ALT, 6, movetoworkspace, 6
      bind = ALT, 7, movetoworkspace, 7
      bind = ALT, 8, movetoworkspace, 8
      bind = ALT, 9, movetoworkspace, 9
      bind = ALT, 0, movetoworkspace, 10
      # same as above, but doesnt switch to the workspace
      bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
      bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
      bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
      bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
      bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5
      bind = $mainMod SHIFT, 6, movetoworkspacesilent, 6
      bind = $mainMod SHIFT, 7, movetoworkspacesilent, 7
      bind = $mainMod SHIFT, 8, movetoworkspacesilent, 8
      bind = $mainMod SHIFT, 9, movetoworkspacesilent, 9
      bind = $mainMod SHIFT, 0, movetoworkspacesilent, 10
      
      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1
      
      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow
    '';
  };
}
