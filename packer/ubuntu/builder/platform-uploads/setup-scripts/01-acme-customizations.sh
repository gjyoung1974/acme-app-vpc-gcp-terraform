#!/bin/bash -xe

# skip interactive post-install configuration steps
export DEBIAN_FRONTEND=noninteractive

sudo apt-get update -y
sudo apt-get install -y curl software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible

# Update base
sudo apt-get update -y
sudo apt-get -y \
  -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" upgrade

# install base packages
sudo apt-get install -y --force-yes \
  ansible \
  xfsprogs \
  tmux \
  htop \
  vim \
  debconf-utils \
  unzip \
  jq

# install a sane python sitewide
sudo apt-get install -y build-essential python-dev python-pip ipython python-setuptools libffi-dev libssl-dev

# hack, remove existing ansible to resolve a bug
sudo rm -rf /usr/local/lib/python2.7/dist-packages/ansible*

# TODO: move all pip packages into setup.py
# sudo easy_install pip
# sudo pip install setuptools -U
# sudo pip install awscli con-fu netaddr ansible==2.2

# Update to Linux HWE/LTS to reolve Intel CVEs
# https://wiki.ubuntu.com/SecurityTeam/KnowledgeBase/SpectreAndMeltdown
# sudo apt-get install \
#   -o Dpkg::Options::="--force-confdef" \
#   -o Dpkg::Options::="--force-confold" -y \
#   linux-image-hwe-generic-trusty \
#   linux-headers-generic-lts-xenial

# # AWS bootstrap tools
# sudo mkdir -p /opt/cfn
# pushd /opt/cfn
# sudo curl -o aws-cfn-bootstrap-latest.tar.gz https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz
# sudo tar zxvf aws-cfn-bootstrap-latest.tar.gz
# sudo easy_install aws-cfn-bootstrap-1.4/
# popd

# no strict modes since our vgs keys are placed in /etc
sudo sed -i 's/^StrictModes.*/StrictModes no/g' /etc/ssh/sshd_config
