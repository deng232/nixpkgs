sudo fallocate -l 32G /var/tmp/nix-zed.swap
sudo chmod 600 /var/tmp/nix-zed.swap
sudo mkswap /var/tmp/nix-zed.swap
sudo swapon -p 100 /var/tmp/nix-zed.swap

sudo systemctl set-property --runtime nix-daemon.service \
  MemoryMax=20G \
  MemorySwapMax=32G \
  CPUQuota=1200% \
  AllowedCPUs=0-11

nix-build  -j 1 -E '
let
  pkgs = import <nixpkgs> {};
in
  pkgs.callPackage ./package.nix {}
'

sudo swapoff /var/tmp/nix-zed.swap
sudo rm -f /var/tmp/nix-zed.swap
