FROM debian:buster

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Or your actual UID, GID on Linux if not the default 1000
ARG USERNAME=crystal
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Configure apt, install packages and tools
RUN apt-get update \	
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    #
    # Create a non-root user to use if preferred
    && groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get install -y sudo curl gnupg build-essential llvm procps gdb linux-perf git \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
    #
    # Clean up
    #&& apt-get autoremove -y \
    #&& apt-get clean -y \
    #&& rm -rf /var/lib/apt/lists/*

#install crystal lang
RUN curl -sSL https://dist.crystal-lang.org/apt/setup.sh | sudo bash \
	&& apt-get -y install libgc-dev crystal libxml2-dev libyaml-dev libgmp-dev libreadline-dev libz-dev \
	&& mkdir /opt/crystal && chown $USERNAME /opt/crystal

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=

USER $USERNAME
ENTRYPOINT ["/entrypoint.sh"]