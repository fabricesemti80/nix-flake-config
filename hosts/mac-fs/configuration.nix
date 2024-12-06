{ config, pkgs, ... }: {
  # Basic system configuration
  networking.hostName = "mac-fs";
  
  # Enable Nix daemon
  services.nix-daemon.enable = true;
  
  # User configuration
  users.users.fs = {
    name = "fs";
    home = "/Users/fs";
  };

  # System packages and features
  programs.fish.enable = true;
  nixpkgs.config.allowUnfree = true;
  
  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = 4;
}
