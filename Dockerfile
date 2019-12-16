FROM ubuntu:18.04

# ARGUMENTS
ARG SDK_MANAGER_VERSION=0.9.14-4964
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
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        sudo \
        apt-utils \
        tzdata \
        git \
        bash-completion \
        command-not-found \
        libgconf-2-4 \
        libcanberra-gtk-module \
        libcanberra-gtk3-module \
        libgtk-3-0 \
        libx11-xcb1 \
        libxss1 \
        libnss3 \
        libxtst6 \
        python \
        sshpass \
        less \
        net-tools \
        usbutils \
        locales \
        netcat-traditional \
        netcat-openbsd \
        openssh-client \
        iproute2 \
        iptables \
        dnsutils \
        gpg \
        gpg-agent \
        gpgconf \
        gpgv \
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
