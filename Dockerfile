FROM archlinux:base-devel

ARG AUR_RPC_BASE_URL="https://aur.archlinux.org/rpc/v5"
ARG PACKAGE_NAME=""
ARG BUILD_ALL_AUR_DEPENDS="no"

COPY --chown=root:root buildpackage.sh /buildpackage.sh
RUN mkdir /pkgout
VOLUME /pkgout

CMD /buildpackage.s $PACKAGE_URL
