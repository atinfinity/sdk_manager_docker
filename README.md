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

## Notes

If you get errors like this, it means that QEMU is not installed in host/container

![image](https://user-images.githubusercontent.com/8092481/117409016-4f604e00-af2e-11eb-87d8-0eb2975b6550.png)

To configure QEMU, run below, either on host, or the running container.

```shell
$ ./configure_qemu.sh
```
