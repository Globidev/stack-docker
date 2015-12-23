FROM debian

MAINTAINER guillaume.depardon@gmail.com

# Install curl and stack dependencies
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    libgmp-dev \
    xz-utils \
    zlib1g-dev \
    libghc-unix-dev

# Install stack
RUN curl -L https://www.stackage.org/stack/linux-x86_64 > /tmp/stack.tar.gz
RUN tar xf /tmp/stack.tar.gz -C /tmp/ --strip-component 1
RUN chmod +x /tmp/stack
RUN mv /tmp/stack /usr/local/bin/stack

# User specific configuration
ARG uid=1000
ARG gid=1000
ARG user=docker
ARG group=docker
RUN groupadd -f -g ${gid} ${group}
RUN useradd -m -u ${uid} -g ${gid} ${user}
USER ${user}

ENV STACK_ROOT /stack/${user}/.stack

WORKDIR /app

ENTRYPOINT ["stack"]
