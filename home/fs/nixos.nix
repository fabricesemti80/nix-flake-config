{ config, pkgs, ... }: {
  home.username = "fs";
  home.homeDirectory = "/home/fs";
  
  programs.git = {
    enable = true;
    userName = "Fabrice Semti";
    userEmail = "fabrice@fabricesemti.com";
  };

  programs.fish = {
    enable = true;
  };
  # Remove the vscode-server configuration as it's not a valid module
  # Instead, the systemd service in configuration.nix will handle VS Code Server

  home.packages = with pkgs; [
    firefox
    git
  ];

  home.stateVersion = "24.05";
}
