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

  # FIXME: uncomment the next block to make vscode running in Windows "just work" with NixOS on WSL
  # solution adapted from: https://github.com/K900/vscode-remote-workaround
  # more information: https://github.com/nix-community/NixOS-WSL/issues/238 and https://github.com/nix-community/NixOS-WSL/issues/294
  systemd.user = {
    paths.vscode-remote-workaround = {
      wantedBy = ["default.target"];
      pathConfig.PathChanged = "%h/.vscode-server/bin";
    };
    services.vscode-remote-workaround.script = ''
      for i in ~/.vscode-server/bin/*; do
        if [ -e $i/node ]; then
          echo "Fixing vscode-server in $i..."
          ln -sf ${pkgs.nodejs_18}/bin/node $i/node
        fi
      done
    '';
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
}
