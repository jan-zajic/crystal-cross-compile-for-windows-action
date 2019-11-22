FROM debian:buster

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Configure apt, install packages and tools
RUN apt-get update \	
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    && apt-get install -y curl gnupg build-essential llvm procps gdb linux-perf git \
    # Clean up
    #&& apt-get autoremove -y \
    #&& apt-get clean -y \
    #&& rm -rf /var/lib/apt/lists/*

#install crystal lang
RUN curl -sSL https://dist.crystal-lang.org/apt/setup.sh | bash \
	&& apt-get -y install libgc-dev crystal libxml2-dev libyaml-dev libgmp-dev libreadline-dev libz-dev

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]