{ pkgs, ... }:

{
  users.users.ethan = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    home = "/home/ethan";
    shell = pkgs.fish;
    hashedPassword = "$y$j9T$NhzHc4gV8OcCRP5t1YiEV/$y6o8GJKQMBCJdg3wy3kPI0YzmozeGfK/GpZHssdKon1";
  };

  programs.fish.enable = true;

  users.users.root = {
    hashedPassword = "$y$j9T$L5Yz7H8/NNtAioH0VlOsJ0$wl3CxYAKs7v9TH9WLBDHf6FePID3u1PATPQ7XHomJH0";
  };
}
