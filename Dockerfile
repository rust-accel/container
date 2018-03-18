FROM nvidia/cuda

RUN apt-get update && apt-get install -y \
  git \
  curl \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly
ENV PATH $PATH:/root/.cargo/bin
ENV LD_LIBRARY_PATH /usr/local/cuda/lib64:/usr/local/cuda/lib64/stubs
RUN cargo install xargo cargo-check
RUN chown -R root:users /root && chmod -R 770 /root
RUN mkdir -p /source
WORKDIR /source
