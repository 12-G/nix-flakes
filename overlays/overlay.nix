{ pkgs, flake, ... }:

{
  nixpkgs.overlays = with flake; [
    inputs.neovim-nightly-overlay.overlay
    inputs.rust-overlay.overlays.default
  ];

  environment.systemPackages = with pkgs; [
    rust-bin.stable.latest.default
    neovim-nightly
  ];
}
