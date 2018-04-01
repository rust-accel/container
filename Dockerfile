FROM nvidia/cuda

RUN apt-get update && apt-get install -y \
  git \
  curl \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
COPY llvm.list /etc/apt/sources.list.d/llvm.list
RUN curl https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
  && apt-get update \
  && apt-get install -y llvm-6.0 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly
ENV PATH $PATH:/root/.cargo/bin
RUN cargo install xargo cargo-check
RUN rustup component add rust-src rustfmt-preview
RUN chown -R root:users /root && chmod -R 770 /root
ENV LIBRARY_PATH "/usr/local/cuda/lib64:/usr/local/cuda/lib64/stubs"
ENV LD_LIBRARY_PATH "/usr/local/cuda/lib64:/usr/local/cuda/lib64/stubs"
RUN mkdir -p /source
WORKDIR /source
