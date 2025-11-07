{ config, lib, pkgs, ... }:

{
    imports = [
        #include NixOS-WSL modules
        <nixos-wsl/modules>
    ];

    wsl = {
        enable = true;
        defaultUser = "seiji";
        docker-desktop.enable = true;
    };

    system.stateVersion = "25.05";

    networking.hostName = "richard";
    time.timeZone = "Asia/Tokyo";
    services.xserver.xkb.layout = "us";

    # Install packages
    environment.systemPackages = with pkgs; [
        tmux
        neovim
        stow
        starship
        git
        subversion

        fd
        fzf
        htop
        neofetch
        tree
        colordiff

        cargo
        bun
        nodejs_24
        gcc
        go
        php
        ruby
        rubyPackages.rails
    ];

    programs = {
        fish.enable = true;
        starship.enable = true;
    };

    # Enable SSH Daemon
    services.openssh.enable = true;

    # Enable Docker - ⛔ Set to false when using in WSL and install Docker desktop⛔
    virtualisation.docker.enable = true;

    users = {
        groups.docker = {};
        users.seiji = {
            description = "The lion has testicular torsion";
            shell = pkgs.fish;
            extragroups = [ "docker", "wheel" ];
            packages = with pkgs; [];
        };
    };
}
