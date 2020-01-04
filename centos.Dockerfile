FROM nvidia/cuda:CUDA_VERSION-devel-centosCENTOS_VERSION

COPY cuda.conf /etc/ld.so.conf.d
RUN ldconfig

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH /root/.cargo/bin:$PATH

RUN cargo install ptx-linker
RUN rustup toolchain add nightly-2020-01-02 \
 && rustup target add nvptx64-nvidia-cuda --target nightly-2020-01-02
