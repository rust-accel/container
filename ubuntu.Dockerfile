FROM nvidia/cuda:CUDA_VERSION-devel-ubuntuUBUNTU_VERSION

COPY cuda.conf /etc/ld.so.conf.d
RUN ldconfig

RUN apt-get update \
 && apt-get install -y curl \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH /root/.cargo/bin:$PATH

RUN cargo install ptx-linker
RUN rustup toolchain add nightly-2020-01-02 \
 && rustup target add nvptx64-nvidia-cuda --target nightly-2020-01-02
