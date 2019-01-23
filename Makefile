
registory := registry.gitlab.com/rust-cuda/container

targets := \
	cuda10.0-ubuntu18.04 \
	cuda9.2-ubuntu16.04  \
	cuda9.1-ubuntu16.04  \
	cuda9.0-ubuntu16.04  \
	cuda8.0-ubuntu16.04

push_targets := $(addprefix push/,$(targets))

all: $(targets)
push: $(push_targets)

login:
	docker login $(registory)

$(targets):
	docker build . --target $@ -t $(registory):$@

$(push_targets): login
	docker push $(registory):$(notdir $@)
