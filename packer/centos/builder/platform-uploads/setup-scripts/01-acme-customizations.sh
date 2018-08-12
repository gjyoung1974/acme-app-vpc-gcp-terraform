#!/bin/bash -xe

# install base packages
sudo yum -y clean all
sudo yum -y update

sudo yum -y install \
  ansible \
  xfsprogs \
  tmux \
  htop \
  vim \
  unzip \
  jq

# install a sane python sitewide
sudo yum -y groupinstall 'Development Tools'
sudo yum -y install python-devel python-pip ipython python-setuptools libffi-dev libssl-dev

# hack, remove existing ansible to resolve a bug
sudo rm -rf /usr/local/lib/python2.7/dist-packages/ansible*

# sudo pip install con-fu netaddr

# # GCP bootstrap tools
# sudo mkdir -p /opt/cfn
# pushd /opt/cfn
## TODO change this to GCP vs AWS
# sudo curl -o aws-cfn-bootstrap-latest.tar.gz https://s3.amazonaws.com/cloudformation-examples/aws-cfn-bootstrap-latest.tar.gz
# sudo tar zxvf aws-cfn-bootstrap-latest.tar.gz
# sudo easy_install aws-cfn-bootstrap-1.4/
# popd

# no strict modes since our vgs keys are placed in /etc
sudo sed -i 's/^StrictModes.*/StrictModes no/g' /etc/ssh/sshd_config
