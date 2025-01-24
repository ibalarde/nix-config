{ config, pkgs, ... }:
{
    imports = [
        ./syncthing.nix
        ./battery.nix
    ];
}
