FROM ubuntu:18.04

# ARGUMENTS
ARG SDK_MANAGER_VERSION=1.9.1-10844
ARG SDK_MANAGER_DEB=sdkmanager_${SDK_MANAGER_VERSION}_amd64.deb
ARG GID=1000
ARG UID=1000

# add new sudo user
ENV USERNAME jetpack
ENV HOME /home/$USERNAME
RUN useradd -m $USERNAME && \
        echo "$USERNAME:$USERNAME" | chpasswd && \
        usermod --shell /bin/bash $USERNAME && \
        usermod -aG sudo $USERNAME && \
        mkdir /etc/sudoers.d && \
        echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
        chmod 0440 /etc/sudoers.d/$USERNAME && \
        # Replace 1000 with your user/group id
        usermod  --uid ${UID} $USERNAME && \
        groupmod --gid ${GID} $USERNAME

# install package
RUN yes | unminimize && \
    apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        git \
        gpg \
        gpg-agent \
        gpgconf \
        gpgv \
        less \
        libcanberra-gtk-module \
        libcanberra-gtk3-module \
        libgconf-2-4 \
        libgtk-3-0 \
        libnss3 \
        libx11-xcb1 \
        libxss1 \
        libxtst6 \
        net-tools \
        python \
        sshpass \
        chromium-browser \
        qemu-user-static \
        binfmt-support \
        libxshmfence1 \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# set locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# install SDK Manager
USER jetpack
COPY --chown=jetpack:jetpack ${SDK_MANAGER_DEB} /home/${USERNAME}/
WORKDIR /home/${USERNAME}
RUN sudo apt-get install -f /home/${USERNAME}/${SDK_MANAGER_DEB}
RUN rm /home/${USERNAME}/${SDK_MANAGER_DEB}

# configure QEMU to fix https://forums.developer.nvidia.com/t/nvidia-sdk-manager-on-docker-container/76156/18
# And, I refered to https://github.com/MiroPsota/sdkmanagerGUI_docker
COPY --chown=jetpack:jetpack configure_qemu.sh /home/${USERNAME}/
ENTRYPOINT ["/bin/bash", "-c", "/home/jetpack/configure_qemu.sh"]
