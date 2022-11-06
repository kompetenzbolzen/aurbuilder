FROM archlinux:base-devel

ARG AUR_RPC_BASE_URL="https://aur.archlinux.org/rpc/"
ARG PACKAGE_NAME=""
ARG BUILD_ALL_AUR_DEPENDS="no"
ARG PACKAGER="John Doe <john@doe.com>"

RUN pacman --noconfirm -Syu
RUN pacman --noconfirm -S git sudo

RUN groupadd sudo
RUN useradd -G sudo -d /workdir -m aurbuilder
COPY --chown=root:root sudoers /etc/sudoers


RUN mkdir /pkgout /db
VOLUME /pkgout
VOLUME /db

RUN pacman --noconfirm -S python python-requests

RUN mkdir -p /opt/aurbuilder

COPY --chown=root:root bin/ /opt/aurbuilder
ENV PATH="${PATH}:/opt/aurbuilder"

CMD buildpackage.sh
