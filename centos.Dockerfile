FROM nvidia/cuda:CUDA_VERSION-devel-centosCENTOS_VERSION

COPY cuda.conf /etc/ld.so.conf.d
RUN ldconfig

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH /root/.cargo/bin:$PATH

RUN cargo install ptx-linker
