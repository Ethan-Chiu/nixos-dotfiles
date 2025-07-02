{ config, pkgs, ... }:

let
  t2fanrdPkg = import ./t2fanrd-package.nix { inherit pkgs; };
in {
  environment.systemPackages = [ t2fanrdPkg ];

  # Reference: https://github.com/t2linux/fedora/blob/2947fdc909a35f04eb936a4f9c0f33fe4e52d9c2/t2fanrd/t2fanrd.service
  systemd.services.t2fanrd = {
    description = "T2FanRD daemon to manage fan curves for T2 Macs";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "exec";
      ExecStart = "${t2fanrdPkg}/bin/t2fanrd";
      Restart = "always";

      PrivateTmp = true;
      ProtectSystem = true;
      ProtectHome = true;
      ProtectClock = true;
      ProtectHostname = true;
      ProtectControlGroups = true;
      ProtectKernelLogs = true;
      ProtectKernelModules = true;
      ProtectProc = "invisible";
      PrivateDevices = true;
      PrivateNetwork = true;
      NoNewPrivileges = true;
      DevicePolicy = "closed";
      KeyringMode = "private";
      LockPersonality = true;
      MemoryDenyWriteExecute = true;
      PrivateUsers = true;
      RemoveIPC = true;
      RestrictNamespaces = true;
      RestrictRealtime = true;
      RestrictSUIDSGID = true;
      SystemCallArchitectures = "native";
    };
  };
}

