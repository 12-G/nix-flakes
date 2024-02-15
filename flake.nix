{
  description = "Ethan's Flakes";
  
  inputs = {
    # Principle inputs (updated by 'nix run .#update')
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-flake.url = "github:srid/nixos-flake";
    impermanence.url = "github:nix-community/impermanence";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    rust-overlay.url = "github:oxalica/rust-overlay";
    nur.url = "github:nix-community/NUR";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, ... }@inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [ inputs.nixos-flake.flakeModule ];

      flake = 
        let
          myUserName = "ethan";
      in
      {
      # Configurations for Linux (NixOS) machines
        nixosConfigurations.nixos = self.nixos-flake.lib.mkLinuxSystem {
          nixpkgs.hostPlatform = "x86_64-linux";
          imports = [
            inputs.impermanence.nixosModules.impermanence
            inputs.nur.nixosModules.nur
            # Setup home-manager in NixOS config
            self.nixosModules.home-manager
            {
              home-manager.useUserPackages = true;
              home-manager.useGlobalPkgs = true;
              home-manager.users.${myUserName} = {
                imports = [ 
                  self.homeModules.default 
                  inputs.hyprland.homeManagerModules.default
                  { wayland.windowManager.hyprland.enable = true; }
                ];
                home.stateVersion = "23.11";
              };
            }

            ./modules/impermanence.nix
            ./modules/system.nix
            ./modules/fonts/fonts.nix

            ./overlays/overlay.nix

            ./config/base-desktop.nix
            ./config/user.nix
          ];
        };

        # home-manager configuration
        homeModules.default = { pkgs, ... }: {
          imports = [
          { _module.args = { inherit myUserName; }; }
          ./home/home.nix 
          ];
        };
      };
    };
}
