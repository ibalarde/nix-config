{ config, pkgs, ... }:
{
    services.syncthing = {
        enable = true;
        user = "isaac";
        dataDir = "/home/isaac/";
        configDir = "/home/isaac/.config/syncthing";
        settings = {
            "MAIN-DESKTOP" = {
                id = "VTKCV3H-RDDH2ZC-KUED22V-RQ7YWZP-O5WDZFC-PYJW576-MZ5XZ3Y-N364OQT";
            };
        };

        folders = {
            "General-share" = {
                id = "msvhu-lacke";
                path = "/home/isaac/general-share/";
                devices = [ "MAIN-DESKTOP" ];
            };
        };
    };
}
