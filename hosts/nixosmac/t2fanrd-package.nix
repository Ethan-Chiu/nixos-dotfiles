{ pkgs }:

pkgs.rustPlatform.buildRustPackage {
  pname = "t2fanrd";
  version = "2025-07-02";
  
  src = pkgs.fetchFromGitHub {
    owner = "GnomedDev";
    repo = "T2FanRD";
    rev = "85027878e4d7fa0170fea1213d6f8dd972d60e83";
    sha256 = "sha256-vOJAYbB/ZcRxM+/lrkab/PcON3vOz3o6eqPvM9hmaOw=";
  };

   cargoHash = "sha256-FKQYiaOTZxD95AWD2zbVjENzMAPrFl/rzhwbkAgGbx0=";
}

