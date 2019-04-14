# GPU Jupyter Keras Pytorch Docker Image
A Docker image for GPU-enabled Keras and PyTorch notebook.
Image is loaded with CUDA 10.0.


### Requirements

NVIDIA drivers, [Docker](https://docs.docker.com/engine/installation/linux/ubuntu/) and [NVIDIA Docker](https://github.com/NVIDIA/nvidia-docker#quick-start) are assumed to be properly installed.


### Installation

Once all dependencies are properly installed, the docker image can be simply "installed" with command:

```bash
$ docker pull wudaown/gpu-jupyter-keras-pytorch:latest
```

Note that this is also the command for upgrading.

Alternatively, one can directly run

```bash
$ nvidia-docker run -it --rm wudaown/gpu-jupyter-keras-pytorch:latest nvidia-smi
```

A `docker pull` will be automatically triggered by this command. This will show a summary table for the NVIDIA GPU status if the docker image is successfully running on your machine.


### Usage

Launch the container with jupyter in background:

```bash
$ nvidia-docker run --it -d -p 8888:8888 -v /path/to/persistent/dir:/root/workspace wudaown/gpu-jupyter-keras-pytorch
```

where `-p 8888:8888` denotes the port mapping from host to container in the format of `-p hostPort:containerPort`.

By default, this will use TensorFlow as backend. If you prefer theano as backend, you can add an environment variable with:

```bash
$ nvidia-docker run -it --rm -e KERAS_BACKEND='theano' wudaown/gpu-jupyter-keras-pytorch bash
```

