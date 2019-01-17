#
# Ubuntu 18.04
#
FROM ubuntu:18.04 as base18
LABEL maintainer="toshiki.teramura@gmail.com"
RUN apt-get update \
 && apt-get install -yq gpg curl \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH $PATH:/root/.cargo/bin

# Install CUDA 10.0
FROM base18 as cuda10.0-ubuntu18.04
RUN apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub \
 && curl -LO http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.0.130-1_amd64.deb \
 && dpkg -i cuda-repo-ubuntu1804_10.0.130-1_amd64.deb \
 && rm -f cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
RUN apt-get update \
 && apt-get install -yq cuda-minimal-build-10-0 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

#
# Ubuntu 16.04
#
FROM ubuntu:16.04 as base16
LABEL maintainer="toshiki.teramura@gmail.com"
RUN apt-get update \
 && apt-get install -yq curl \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
# Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH $PATH:/root/.cargo/bin

# Install CUDA 9.2
FROM base16 as cuda9.2-ubuntu16.04
RUN apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub \
 && curl -LO http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.2.148-1_amd64.deb \
 && dpkg -i cuda-repo-ubuntu1604_9.2.148-1_amd64.deb \
 && rm -f cuda-repo-ubuntu1604_9.2.148-1_amd64.deb
RUN apt-get update \
 && apt-get install -yq cuda-minimal-build-9-2 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
ENV PATH $PATH:/usr/local/cuda-9.2/bin

# Install CUDA 9.1
FROM base16 as cuda9.1-ubuntu16.04
RUN apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub \
 && curl -LO http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.2.148-1_amd64.deb \
 && dpkg -i cuda-repo-ubuntu1604_9.2.148-1_amd64.deb \
 && rm -f cuda-repo-ubuntu1604_9.2.148-1_amd64.deb
RUN apt-get update \
 && apt-get install -yq cuda-minimal-build-9-1 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
ENV PATH $PATH:/usr/local/cuda-9.1/bin

# Install CUDA 9.0
FROM base16 as cuda9.0-ubuntu16.04
RUN apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub \
 && curl -LO http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.2.148-1_amd64.deb \
 && dpkg -i cuda-repo-ubuntu1604_9.2.148-1_amd64.deb \
 && rm -f cuda-repo-ubuntu1604_9.2.148-1_amd64.deb
RUN apt-get update \
 && apt-get install -yq cuda-minimal-build-9-0 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
ENV PATH $PATH:/usr/local/cuda-9.0/bin

# Install CUDA 8.0
FROM base16 as cuda8.0-ubuntu16.04
RUN apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub \
 && curl -LO https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb \
 && dpkg -i cuda-repo-ubuntu1604_8.0.61-1_amd64.deb \
 && rm -f cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
RUN apt-get update \
 && apt-get install -yq cuda-minimal-build-8-0 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
ENV PATH $PATH:/usr/local/cuda-8.0/bin
