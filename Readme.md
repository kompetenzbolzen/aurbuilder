# AUR PKG Builder

Automated AUR package buildsystem built on Podman capable of resolving AUR dependecies.

## Usage

In normal operation, no intervention should be required.
See **Configuration** and **Installation** for Instruction on setup.

Builds can be manually triggered by `systemctl start aurbuilder-package.service`.
This requires a `aurbuilder-container.service` run to have completed beforehand.

The repository index can be force-updated with `systemctl start aurbuilder-repo.service`.

## Client pacman Configuration

```ini
[<repo name>]
Server = http://aurbuilder.example.com/
SigLevel = Optional TrustAll
```

## Configuration

### Packages to build

To build, the *exact* name has to be added in a new line `/etc/aurbuilder/packages`.
It will be included in the next run.

**CAUTION:** Packages removed from this list will *NOT* be automatically deleted.
It is possible for old (possibly insecure) builds to linger around.
Delete them manually for now.

### Build settings

General settings are stored in `/etc/aurbuilder/config`.

#### `FORCE_REBUILD`

`yes/[no]`

All packages will be rebuilt every run

#### `PACKAGER`

Name and mail of the packager to be stored in the packages.
Format: `Na Me <name@mail.com>`

#### `REPONAME`

The name to be used for the package database.
This has to match with the repositories name in `pacman.conf`.

## Installation

aurbuilder is designed to be run on Arch Linux.
Use the `PKGBUILD` in `pkgbuild/` to install with `makepkg -si`.

Enable the systemd timers to activate the automated builds:
`systemctl enable aurbuilder-container.timer` and
`systemctl enable aurbuilder-package.timer`.

### nginx

To access the repository conveniently from remote hosts, a webserver is needed.
aurbuilder comes with a sensible default configuration in `/usr/share/aurbuilder/nginx/aurbuilder.conf`.

It has to be included in a `location` block:

```nginx
# /etc/nginx/nginx.conf

http {
    # ...
    server {
        # ...

        location /mycoolrepo {
            include /usr/share/aurbuilder/nginx/aurbuilder.conf;
        }
    }
}
```

## Roadmap

aurbuilder is very bare-bones.
There are several features and improvements that I plan to add to improve security and ease of use.
I would strongly recommend against using aurbuilder in any mission critical capacity.

* Package and repo signing with GPG
* Better repo management, autodelete and cleanups

## Locations

| location | description |
| --- | --- |
| `/srv/pkg` | Package output directory |
| `/etc/aurbuilder` | Configuration files |
| `/var/lib/aurbuilder` | Homedir of user (for podman storage) |
| `/usr/share/aurbuilder` | Container buildfiles and nginx config |
| `/usr/lib/aurbuilder` | Executables |
| `/usr/lib/systemd/system` | Systemd Unitfiles |
