# AUR PKG Builder

Docker base AUR Package builder for local arch repo

## Locations

* Output, db and webroot `/srv/arch/`
* Dockerfile and scripts for the Container ``
* Scripts ``

## nginx

Config in `nginx.conf`

```nginx
# in http block

include /etc/nginx/arch.conf;
#include /etc/nginx/arch_ssl.conf;
```

## Workflow

Provided: Package name

* search AUR for package (exact match only!)
* build dependency tree (also search with provided, then there is no exact match)
* prioritize packages in official repos. Don't build them.
* Add all AUR-PKGs in tree to to-build-list
* MAKEPKG ur way thourhg


