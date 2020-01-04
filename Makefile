UBUNTU1604_CUDA_VERSION := 8.0 9.0 9.1 9.2 10.0 10.1 10.2
UBUNTU1804_CUDA_VERSION := 9.2 10.0 10.1 10.2
CENTOS6_CUDA_VERSION := 8.0 9.0 9.1 9.2 10.0 10.1 10.2
CENTOS7_CUDA_VERSION := 8.0 9.0 9.1 9.2 10.0 10.1 10.2

define ubuntu
ubuntu$(1)-cuda$(2):
	sed -e "s/CUDA_VERSION/$(2)/" -e "s/UBUNTU_VERSION/$(1)/" < ubuntu.Dockerfile > $$@.Dockerfile
	docker build -f $$@.Dockerfile -t $$(subst .,,$$@) .
endef

clean:
	rm -rf ubuntu*-cuda*.Dockerfile

all: $(foreach CUDA_VERSION,$(UBUNTU1604_CUDA_VERSION),ubuntu16.04-cuda$(CUDA_VERSION)) \
     $(foreach CUDA_VERSION,$(UBUNTU1804_CUDA_VERSION),ubuntu18.04-cuda$(CUDA_VERSION))

$(foreach CUDA_VERSION,$(UBUNTU1604_CUDA_VERSION),$(eval $(call ubuntu,16.04,$(CUDA_VERSION))))
$(foreach CUDA_VERSION,$(UBUNTU1804_CUDA_VERSION),$(eval $(call ubuntu,18.04,$(CUDA_VERSION))))
