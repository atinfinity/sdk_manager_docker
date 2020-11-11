FROM ubuntu:18.04

# ARGUMENTS
ARG SDK_MANAGER_VERSION=1.3.1-7110
ARG SDK_MANAGER_DEB=sdkmanager_${SDK_MANAGER_VERSION}_amd64.deb

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
        usermod  --uid 1000 $USERNAME && \
        groupmod --gid 1000 $USERNAME

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
COPY ${SDK_MANAGER_DEB} /home/${USERNAME}/
WORKDIR /home/${USERNAME}
RUN sudo apt-get install -f /home/${USERNAME}/${SDK_MANAGER_DEB}

USER root
RUN echo "${USERNAME}:${USERNAME}" | chpasswd
RUN rm /home/${USERNAME}/${SDK_MANAGER_DEB}

  # Configure qemu-user-static to avoid errors of the type:  ERROR : File System and OS : chroot: failed to run command 'mount': Exec format error.
CMD sudo mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc
CMD sudo update-binfmts --enable qemu-aarch64
CMD sudo update-binfmts --enable qemu-arm
CMD sudo update-binfmts --enable qemu-armeb
