# Maintainer: Your Name <youremail@domain.com>
pkgname=aurbuilder
pkgver=0.0
pkgrel=1
pkgdesc="AUR Package builder"
arch=( any )
url="https://gitea.lauch.link/jonas/aurbuilder"
license=('CUSTOM')
groups=()
depends=( podman bash )
makedepends=()
optdepends=()
source=(git+$url.git)
sha256sums=( SKIP ) #autofill using updpkgsums
install=$pkgname.install

pkgver() {
	date +%Y%m%d
}

build() {
	cd "$pkgname"
}

package() {
	cd "$srcdir/$pkgname"
	install -Dt $pkgdir/usr/share/aurbuilder container/{Dockerfile,sudoers}
	install -Dt $pkgdir/usr/share/aurbuilder/bin container/bin/*
	install -Dt $pkgdir/usr/lib/aurbuilder scripts/*
	install -Dt $pkgdir/usr/lib/systemd/system unitfiles/*
	install -Dt $pkgdir/etc/aurbuilder configs/*

}

