{ config, pkgs, ... }: {
  home.username = "fs";
  home.homeDirectory = "/Users/fs";
  
  programs.git = {
    enable = true;
    userName = "Fabrice Semti";
    userEmail = "fabrice@fabricesemti.com";
  };

  programs.fish = {
    enable = true;
  };

  home.packages = with pkgs; [
    firefox
    git
  ];

  home.stateVersion = "24.05";
}
