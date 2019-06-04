# sdk_manager_docker

## Introduction
This is a Dockerfile to use [NVIDIA SDK Manager](https://developer.nvidia.com/embedded/dlc/nv-sdk-manager) on Docker container.

## Requirements
* Docker

## Preparation
### Download NVIDIA SDK Manager
Please download the package of NVIDIA SDK Manager from <https://developer.nvidia.com/embedded/dlc/nv-sdk-manager>.  
And, please put the package of NVIDIA SDK Manager in the same directory as the Dockerfile.  
This time, I used `sdkmanager_0.9.12-4180_amd64.deb`.

### Build Docker image
```
$ docker build -t jetpack .
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

You need type user password during setup of NVIDIA SDK Manager.  
In [this Dockerfile](https://github.com/atinfinity/sdk_manager_docker/blob/master/Dockerfile#L67), user password is set to `jetpack`.  
So, please type `jetpack` as user password.
