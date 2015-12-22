FROM buildpack-deps

MAINTAINER guillaume.depardon@gmail.com

# Install libgmp ...
RUN apt-get update -q && \
    apt-get install -qy libgmp-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

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
