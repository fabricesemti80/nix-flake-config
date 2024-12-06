{ config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  # Basic system configuration
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nix-fs";
  networking.networkmanager.enable = true;

  # System packages and services
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  # User configuration
  users.users.fs = {
    isNormalUser = true;
    description = "Fabrice Semti";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    # FIXME: add your own hashed password
    hashedPassword = "a51f9df93402a323fc18617691424181c73e5f7745fd3d295abc90d401b569b1"; # Enable password login
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBJpVWYmXPpqVmlHdixDR//vdfD+sryvYmpH2Dj1/Otx fabrice@fabricesemti.com"
    ];
  };

  # Enable passwordless sudo for fs
  security.sudo.extraRules = [{
    users = [ "fs" ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" ];
    }];
  }];

  # Enable SSH server
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  # System features
  programs.fish.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.05";


  # Add these lines for locale configuration
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };
}
