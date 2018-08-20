FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

RUN apt-get update && apt-get install -y --no-install-recommends \
         wget  \
         bzip2  \
         libglib2.0-0 \
         libxext6 \
         libsm6 \
         libxrender1 \
         mercurial \
         subversion \
         build-essential \
         cmake \
         git \
         curl \
         vim \
         ca-certificates \
         libjpeg-dev \
         libpng-dev &&\
     rm -rf /var/lib/apt/lists/*
     
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

ENV PATH /opt/conda/bin:$PATH

WORKDIR /libs/

RUN conda install numpy pyyaml mkl mkl-include setuptools cmake cffi typing
RUN conda install -c mingfeima mkldnn
RUN conda install -c pytorch magma-cuda90

RUN git clone --recursive https://github.com/pytorch/pytorch
WORKDIR /libs/pytorch
RUN python setup.py install

RUN pip install -U \
        onnx-coreml \
        tensorboardX \
        tqdm \
        imageio

