FROM archlinux:base-devel

ENV PACKAGE_NAME=""
ENV PACKAGER="John Doe <John.Doe@example.com>"
ENV ARCH="x86_64"
ENV FORCE_REBUILD="no"
ENV CHOWM=""

RUN pacman --noconfirm -Syu
RUN pacman --noconfirm -S git sudo

RUN groupadd sudo
RUN useradd -G sudo -d /workdir -m aurbuilder
COPY --chown=root:root sudoers /etc/sudoers


RUN mkdir /pkgout
VOLUME /pkgout

RUN pacman --noconfirm -S python python-requests

RUN mkdir -p /opt/aurbuilder

COPY --chown=root:root bin/ /opt/aurbuilder
ENV PATH="${PATH}:/opt/aurbuilder"

CMD buildpackage.sh
