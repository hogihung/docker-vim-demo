# ubuntu-ruby-vim 
#
# VERSION 1.0.1
#
# This Dockerfile is used to build a base Ruby development environment with vim.
# Using the Ubuntu Linux 17.10 image, we will add the ruby version manager tool
# RVM as well as install some ruby versions, git, and some common tools.
#
# Build image example:
#   docker build -t ubuntu-ruby-vim:1.0.1 .
#
# Running a container example:
#   docker run -it --name=ubuntu-ruby-vim --hostname=ruby-dev --rm [image-id-here]
#   **Note: the --rm flag is optional.  It will remove the container on exit.
# -------------------------------------------------------------------
FROM ubuntu:17.10
MAINTAINER John F. Hogarty <hogihung@gmail.com>

# Update and install all of the required packages.
RUN apt-get update -y && \
    apt-get install -y curl tar tree wget && \
    apt-get install -y software-properties-common 

# Install Vim 8.x
RUN add-apt-repository -y ppa:jonathonf/vim && \
    apt-get update -y && \
    apt-get install -y vim

# Install Git 2.7.x
RUN apt-get update -y && \
    apt install -y git-core

# Install rvm (Ruby Version Manager)
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
    \curl -sSL   https://get.rvm.io | bash -s stable

RUN /bin/bash -l -c 'source /etc/profile.d/rvm.sh'

# Set bundler as a default gem
RUN echo bundler >> /usr/local/rvm/gemsets/global.gems

# Setup some default flags from rvm (auto install, auto gemset create, quiet curl)
RUN echo "rvm_install_on_use_flag=1\nrvm_gemset_create_on_use_flag=1\nrvm_quiet_curl_flag=1" > ~/.rvmrc

# Preinstall some ruby versions
ENV PREINSTALLED_RUBIES "2.3.5 1.7.23 1.9.3-p551 2.4.1"
RUN /bin/bash -l -c 'for version in $PREINSTALLED_RUBIES; do echo "Now installing Ruby $version"; rvm install $version; rvm cleanup all; done'

# Login shell by default so rvm is sourced automatically and 'rvm use' can be used
ENTRYPOINT /bin/bash -l
