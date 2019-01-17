
targets := \
	cuda10.0-ubuntu18.04 \
	cuda9.2-ubuntu16.04  \
	cuda9.1-ubuntu16.04  \
	cuda9.0-ubuntu16.04  \
	cuda8.0-ubuntu16.04

all: $(targets)

$(targets):
	docker build . --target $@ -t registry.gitlab.com/rust-cuda/container:$@
