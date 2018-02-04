FROM nvidia/cuda:8.0-cudnn5-devel
LABEL maintainer="will.price94+docker@gmail.com"
ARG VERSION=2.4.13.5
ARG CUDA_ARCH_PTX=""
ARG CUDA_ARCH_BIN="6.0 6.1"

RUN apt-get update && \
    apt-get install -y wget

RUN apt-get update && \
    apt-get install -y \
        build-essential \
        cmake \
        git \
        libgtk2.0-dev \
        pkg-config \
        libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
        python-dev \
        python-numpy \
        libtbb2 \
        libtbb-dev \
        libjpeg-dev \
        libpng-dev \
        libtiff-dev \
        libjasper-dev \
        libdc1394-22-dev

RUN mkdir /src
WORKDIR /src
RUN wget "https://github.com/opencv/opencv/archive/$VERSION.zip" -O opencv-$VERSION.zip
RUN apt-get update && \
    apt-get install -y unzip
RUN unzip opencv-$VERSION
RUN mkdir -p opencv_build && \
    cd opencv_build && \
    cmake \
        -D CMAKE_BUILD_TYPE=Release \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D WITH_CUDA=ON \
        -D WITH_CUBLAS=1 \
        -D CUDA_FAST_MATH=1 \
        -D CUDA_ARCH_PTX="$CUDA_ARCH_PTX" \
        -D CUDA_ARCH_BIN="$CUDA_ARCH_BIN" \
        -D ENABLE_FAST_MATH=1 \
        -D INSTALL_C_EXAMPLES=OFF \
        -D INSTALL_PYTHON_EXAMPLES=OFF \
        -D BUILD_EXAMPLES=OFF \
        -D BUILD_DOCS=OFF \
        -D BUILD_PERF_TESTS=OFF \
        -D BUILD_TESTS=OFF \
        -D CMAKE_LIBRARY_PATH=/usr/local/cuda/lib64/stubs \
        ../opencv-$VERSION && \
    make -j $(nproc) && \
    make install
# Mitigate issue with programs not being able to compile without
# static linking of cuda: -D CUDA_USE_STATIC_CUDA_RUNTIME=OFF
# See https://github.com/opencv/opencv/issues/6542 for more
RUN ln -s /usr/local/cuda/lib64/libcudart.so \
          /usr/local/lib/libopencv_dep_cudart.so
