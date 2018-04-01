Windows build system for ungoogled-chromium

This project produces a clean Windows build of ungoogled-chromium on a Linux environment

Tested with the following dependencies:

- VirtualBox 5.2.8
- packer 1.2.2
- vagrant 2.0.2

To build:

```
    $ git submodule update --init
    $ run.sh
```

The output will be in the products/ directory. The build takes a very long time to run as it includes a from-scratch install of Windows, Visual Studio, and the Windows SDK.

Intermediate products:

 - `01-win2016/`: Windows Server 2016 base image
 - `02-win2016-vs.box`: Chromium build environment. Contains all prerequisites for building ungoogled-chromium. This can also be used for development and testing

Caches:

- `vagrant-dotfiles`
- `vagrant-home`
- `cache`: packer download cache

VMs are created in the ~/.VirtualBox folder
