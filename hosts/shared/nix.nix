{ ... }:

{
  nix = {
    # Enable automatic garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      # Enable flakes and new `nix` command
      experimental-features = [ "nix-command" "flakes" ];
      # Deduplicate and optimize nix store
      # PERF: Could cause I/O overhead; consider running `nix store optimize`
      # manually, or setting `nix.optimise` instead
      # auto-optimise-store = true;
    };
  };
}
