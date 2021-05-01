# sdk_manager_docker

## Introduction
This is a Dockerfile to use [NVIDIA SDK Manager](https://docs.nvidia.com/sdk-manager/) on Docker container.

### Important Information
NVIDIA release official Docker image(<https://docs.nvidia.com/sdk-manager/docker-containers/index.html>).  
So, please use this image.

## Requirements
* Docker

## Preparation
### Download NVIDIA SDK Manager
Please download the package of NVIDIA SDK Manager from <https://developer.nvidia.com/nvidia-sdk-manager>.  
And, please put the package of NVIDIA SDK Manager in the same directory as the Dockerfile.  
This time, I used `sdkmanager_1.5.0-7774_amd64.deb`.

### Build Docker image
```
$ docker build -t jetpack .
```

To build a Docker image with a specific SDK Manager version override the ``SDK_MANAGER_VERSION`` variable in the Docker command line

```
$ docker build --build-arg SDK_MANAGER_VERSION=1.5.0-7774 -t jetpack .
```

### Create Docker container
```
$ ./launch_container.sh
```

## Launch NVIDIA SDK Manager
Please launch NVIDIA SDK Manager by the following command.

```
$ sdkmanager
```
