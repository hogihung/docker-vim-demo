# README

The following covers the steps needed to create a Docker image based off of the
provided Dockerfile.  Once the image has been created, you can use the docker
run command to launch a docker container based on the image.

This image was created using the Ubuntu 17.10 docker image and includes the
following tools:

  - Curl
  - Git
  - RVM
  - Ruby
  - Tar
  - Tree
  - Vim


1.  Build the image

```
docker build -t ubuntu-ruby-vim:1.0.1 .
```


2.  Run our Ubuntu based Ruby/Vim image as a container

```
docker run -it --name=ubuntu-ruby-vim --hostname=ruby-dev --rm [image-id-here]
```


3.  Confirm versions of software installed

```
root@ruby-dev:/# ruby -v
ruby 2.3.5p376 (2017-09-14 revision 59905) [x86_64-linux]
root@ruby-dev:/#

root@ruby-dev:/# rvm -v
rvm 1.29.3 (latest) by Michal Papis, Piotr Kuczynski, Wayne E. Seguin [https://rvm.io]
root@ruby-dev:/#

root@ruby-dev:/# git --version
git version 2.14.1
root@ruby-dev:/#

root@ruby-dev:/# vim -h
VIM - Vi IMproved 8.0 (2016 Sep 12, compiled Dec 22 2017 08:49:31)
```
