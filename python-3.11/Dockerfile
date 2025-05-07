#
#--------------------------------------------------------------------------
# Playwright
# Maintainers: chinayin <whereismoney@qq.com>
# GitRepo: https://github.com/chinayin-docker/playwright
#--------------------------------------------------------------------------
#

FROM python:3.11-slim
LABEL maintainer="chinayin <whereismoney@qq.com>"
ENV DEBIAN_FRONTEND=noninteractive

RUN set -eux \
    pwd \
    tree .

COPY prebuildfs /

ARG CHANGE_SOURCE=true
ENV CHANGE_SOURCE ${CHANGE_SOURCE}
ARG TZ=Asia/Shanghai
ENV TZ ${TZ}
RUN if [ ${CHANGE_SOURCE} = true ]; then \
    echo "change source." \
    && sed -i 's|deb.debian.org|mirrors.aliyun.com|g' /etc/apt/sources.list.d/debian.sources \
;fi && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone;

RUN set -eux \
    ## alias
    && printf "alias ls='ls --color=auto'\nalias ll='ls -l --color=auto'\nalias l='ls -lA --color=auto'" >> /etc/profile.d/ll.sh \
    ## install packages
    && install_packages procps gcc \
    ## set limits.conf
    && printf "* soft nofile 65536\n* hard nofile 65536\n" >> /etc/security/limits.conf \
    ## set sysctl.conf
    && printf "vm.max_map_count=262144\nfs.file-max=65536" >> /etc/sysctl.conf \
    ## linux user
    && groupmod -o -g 1000 www-data && usermod -o -u 1000 -g www-data www-data \
    ## end
    && echo 'prebuild done.';

ARG PLAYWRIGHT_VERSION
ENV PLAYWRIGHT_VERSION ${PLAYWRIGHT_VERSION}
ARG PLAYWRIGHT_INSTALL_BROWSERS=""
ENV PLAYWRIGHT_INSTALL_BROWSERS ${PLAYWRIGHT_INSTALL_BROWSERS}
ENV PLAYWRIGHT_BROWSERS_PATH=/ms-playwright

#    Bake in browsers & deps.
#    Browsers will be downloaded in `/ms-playwright`.
#    Note: make sure to set 777 to the registry so that any user can access registry.
RUN mkdir /ms-playwright \
    && pip install --no-cache-dir playwright==$PLAYWRIGHT_VERSION \
    && playwright install ${PLAYWRIGHT_INSTALL_BROWSERS} --with-deps \
    && rm -rf /var/lib/apt/lists/* \
    # Workaround for https://github.com/microsoft/playwright/issues/27313
    # While the gstreamer plugin load process can be in-process, it ended up throwing
    # an error that it can't have libsoup2 and libsoup3 in the same process because
    # libgstwebrtc is linked against libsoup2. So we just remove the plugin.
    && if [ "$(uname -m)" = "aarch64" ]; then \
        rm -f /usr/lib/aarch64-linux-gnu/gstreamer-1.0/libgstwebrtc.so; \
    else \
        rm -f /usr/lib/x86_64-linux-gnu/gstreamer-1.0/libgstwebrtc.so; \
    fi \
    && chmod -R 777 /ms-playwright
