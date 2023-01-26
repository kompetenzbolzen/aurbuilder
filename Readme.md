# AUR PKG Builder

Docker base AUR Package builder for local arch repo

Packages are put in `/srv/arch/`

## Workflow

Provided: Package name

* search AUR for package (exact match only!)
* build dependency tree (also search with provided, then there is no exact match)
* prioritize packages in official repos. Don't build them.
* Add all AUR-PKGs in tree to to-build-list
* MAKEPKG ur way thourhg


