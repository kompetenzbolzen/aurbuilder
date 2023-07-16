# AUR PKG Builder

Automated AUR package buildsystem.


## Installation

aurbuilder is designed to be run on Arch Linux.
Use the `PKGBUILD` in `pkgbuild/` to install with `makepkg -si`.

Enable the systemd timers to activate the automated builds:
`systemctl enable aurbuilder-container.timer` and
`systemctl enable aurbuilder-package.timer`.

## Usage

Add packages to build in `/etc/aurbuilder/packages` (one per line).

Builds can be manually triggered by `systemctl start aurbuilder-package.service`.
This requires a `aurbuilder-container.service` run to have completed beforehand.

## Locations

| location | description |
| --- | --- |
| `/srv/pkg` | Package output directory |
| `/etc/aurbuilder` | Configuration files |
| `/var/lib/aurbuilder` | Homedir of user (for podman storage) |
| `/usr/share/aurbuilder` | Container buildfiles |
| `/usr/lib/aurbuilder` | Executables |
| `/usr/lib/systemd/system` | Systemd Unitfiles |
