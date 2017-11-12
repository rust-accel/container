FROM nvidia/cuda

RUN apt-get update && apt-get install -y \
  curl \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH $PATH:/root/.cargo/bin
RUN cargo install xargo && rustup toolchain add nightly
RUN chown -R root:users /root && chmod -R 770 /root
RUN mkdir -p /source
WORKDIR /source
