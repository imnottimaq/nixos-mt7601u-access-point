## Installation
In your `configuration.nix`:
```
let mt7601u-kernel-module = pkgs.callPackage ../pkgs/nixos-mt7601u-access-point/default.nix { kernel = config.boot.kernelPackages.kernel; }; in {
  boot.extraModulePackages = [ mt7601u-kernel-module ];
}
```
Point the default.nix path to this repo. (in my case, it's in /etc/nixos/pkgs/, while my `configuration.nix` is in /etc/nixos/nixos/)

### Installation notes
- **You may need to remove .git from the cloned directory.**
- Depending on how you clone this repository, you may need to add the `--impure` argument to your `nixos-rebuild`.
- You may have to set `coherent_pool=4M` as a command-line kernel parameter for proper functionality.

## Usage
Apply configuration and reboot (or use modprobe). From here, you should see it available for AP mode with `iw list` (may need to run `nix-shell -p iw`):
```
Supported interface modes:
		 * managed
		 * AP
		 * AP/VLAN
		 * monitor
```
You can bring an access point up with `nmcli device wifi hotspot con-name access-point` if using NetworkManager. Performance is subpar, do not plan on usage for reliability-dependent tasks such as gaming or voice/video calls.
