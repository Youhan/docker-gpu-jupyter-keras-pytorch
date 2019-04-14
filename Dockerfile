# FROM defines the base image
FROM tensorflow/tensorflow:latest-gpu-jupyter
MAINTAINER wudaown <wudaown@gmail.com>

# Disable interactive interface
ARG DEBIAN_FRONTEND=noninteractive

# RUN executes a shell command
# You can chain multiple commands together with &&
# A \ is used to split long lines to help with readability
RUN apt-get update && apt-get install -y \
    # tools
    git \
    vim \
    python-setuptools \
    python-virtualenv \
    graphviz \
    htop \
    liblzma-dev

# Install keras and theano dependencies not included in
# https://github.com/tensorflow/tensorflow/blob/master/tensorflow/tools/docker/Dockerfile.gpu
RUN pip install -U pip && pip --no-cache-dir install --upgrade \
    pandas \
    h5py \
    pyyaml \
    virtualenv \
    graphviz \
    pydot \
    keras-tqdm \
    torch \
    torchvision \
    nltk \
    h5py \
    gensim

# Enable the widgetsnbextension for notebook
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension

# Install theano and keras
RUN pip --no-cache-dir install --no-deps \
    theano \
    keras \
    git+https://www.github.com/farizrahman4u/keras-contrib.git

# Set keras backend to tensorflow by default
ENV KERAS_BACKEND tensorflow

COPY ./jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py
COPY ./run_jupyter.sh /run_jupyter.sh

# Add /root/workspace to PYTHONPATH for convenience
ENV PYTHONPATH /root/workspace:$PYTHONPATH

# Set the working directory
WORKDIR /root/workspace

# CMD defines the default command to be run in the container
# CMD is overridden by supplying a command + arguments to
# `docker run`, e.g. `nvcc --version` or `bash`
CMD ["/run_jupyter.sh"]
