# OpenCV2 Dockerfile

[![Build Status](https://travis-ci.org/dl-container-registry/opencv2.svg?branch=master)](https://travis-ci.org/dl-container-registry/opencv2)
[![Dockerhub link](https://img.shields.io/badge/hosted-dockerhub-22b8eb.svg)](https://hub.docker.com/r/willprice/opencv2-cuda8/~/settings/)
[![Singularity hub hosted](https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg)](https://singularity-hub.org/collections/530)


## Usage

Build other containers from this base image, it contains a prebuilt version of
OpenCV 2.4.13.4 at `/src/opencv_build` installed to `/usr/local/OpenCV`
(containing CMake files for building other projects).
