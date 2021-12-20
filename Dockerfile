FROM nvidia/cuda:11.4.2-cudnn8-runtime-ubuntu18.04

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
     
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 

ENV PATH /opt/conda/bin:$PATH

WORKDIR /libs/

RUN conda install numpy pyyaml mkl mkl-include setuptools cmake cffi typing
RUN conda install -c mingfeima mkldnn
RUN conda install -c pytorch pytorch=1.9.1 torchvision cudatoolkit=10.2
RUN conda install -c fvcore -c iopath -c conda-forge fvcore iopath
RUN conda install -c bottler nvidiacub
RUN pip install -U pytorch3d -f https://dl.fbaipublicfiles.com/pytorch3d/packaging/wheels/py39_cu102_pyt191/download.html

RUN pip install -U \
        onnx-coreml \
        tensorboardX \
        tqdm \
        imageio \
        jupyter \
        loguru \
        k3d \
        torchsummary \
	tensorboard \
	matplotlib \
	cloudpickle \
	boto3 


RUN apt-get update && apt-get install -y ffmpeg libsm6 libxext6 
RUN conda install -c open3d-admin -c conda-forge open3d
