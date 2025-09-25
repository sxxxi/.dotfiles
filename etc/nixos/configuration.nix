{ config, lib, pkgs, ... }:

{
    imports = [
        #include NixOS-WSL modules
        <nixos-wsl/modules>
    ];

    wsl.enable = true;
    wsl.defaultUser = "domino";

    system.stateVersion = "25.05";

    networking.hostName = "richard";
    time.timeZone = "Asia/Tokyo";
    services.xserver.xkb.layout = "us";

    # Install packages
    environment.systemPackages = with pkgs; [
        docker-compose  # comment out when installing in WSL
        tmux starship stow neovim git subversion
        bun nodejs_24 php go cargo
        fd fzf
    ];

    programs.fish.enable = true;

    # Enable SSH Daemon
    services.openssh.enable = true;

    # Enable Docker - ⛔ Set to false when using in WSL and install Docker desktop⛔
    virtualisation.docker.enable = true;

    # Configure sudoers group
    security.sudo = {
        enable = true;
        extraRules = [{
            groups = [ "sudo" ];
            commands = [ "ALL" ];
        }];
    };

    users.users.domino = {
        description = "Raging Heterosexual";
        shell = pkgs.fish;
        extraGroups = [ "docker" "sudo" ];
        packages = with pkgs; [];
    };
}
