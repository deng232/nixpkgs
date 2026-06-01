sudo systemctl set-property --runtime nix-daemon.service \
  MemoryMax=20G \
  MemorySwapMax=0 \
  CPUQuota=1200% \
  AllowedCPUs=0-11


  nix-build -E '
let
  pkgs = import <nixpkgs> {};
in
  pkgs.callPackage ./package.nix {}
'
