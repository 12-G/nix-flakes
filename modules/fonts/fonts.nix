{ pkgs, ... }:

{
  fonts = {
    # use fonts specified by user rather than default ones.
    enableDefaultPackages = false;
    fontDir.enable = true;

    packages = with pkgs; [
      # my favorite font
      maple-mono-NF

      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-extra

      (nerdfonts.override {
        fonts = [
	  "FiraCode"
	  "JetBrainsMono"
	];
      })
    ];

    # user defined fonts
    fontconfig.defaultFonts = {
      serif = [ "Maple Mono SC NF" "Noto Color Emoji" "Source Code Pro" ];
      sansSerif = [ "Maple Mono SC NF" "Noto Color Emoji" ];
      monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
