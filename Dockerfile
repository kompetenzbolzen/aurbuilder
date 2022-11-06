FROM archlinux:base-devel
RUN pacman --noconfirm -Syu

ARG AUR_RPC_BASE_URL="https://aur.archlinux.org/rpc/"
ARG PACKAGE_NAME=""
ARG BUILD_ALL_AUR_DEPENDS="no"

RUN mkdir /pkgout /db
VOLUME /pkgout
VOLUME /db

RUN pacman --noconfirm -S python python-requests

COPY --chown=root:root buildpackage.sh /buildpackage.sh

CMD /buildpackage.sh
