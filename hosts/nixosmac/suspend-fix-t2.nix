{ config, pkgs, ... }:

{
  systemd.services."apple-bce-reload" = {
    description = "Disable and Re-Enable Apple BCE Module (and Wi-Fi)";
    wantedBy = [ "sleep.target" ];
    before = [ "sleep.target" ];

    unitConfig = {
      StopWhenUnneeded = true;
    };

    serviceConfig = {
      User = "root";
      Type = "oneshot";
      RemainAfterExit = true;

      ExecStart = [
        "${pkgs.kmod}/bin/modprobe -r hci_bcm4377"
        "${pkgs.kmod}/bin/modprobe -r brcmfmac_wcc"
        "${pkgs.kmod}/bin/modprobe -r brcmfmac"
        "${pkgs.kmod}/bin/rmmod -f apple-bce"
      ];

      ExecStop = [
        "${pkgs.kmod}/bin/modprobe apple-bce"
        "${pkgs.kmod}/bin/modprobe brcmfmac"
        "${pkgs.kmod}/bin/modprobe brcmfmac_wcc"
        "${pkgs.kmod}/bin/modprobe hci_bcm4377"
      ];
    };
  };
}

