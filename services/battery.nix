{ config, pkgs, ... }:
{
    powerManagement.enable = true;
    
    services.thermald.enable = true;

    services.tlp.enable = true;
}
