#!/usr/bin/env bash

# * (c) Copyright IBM Corporation. 2019
# * SPDX-License-Identifier: Apache-2.0
# * By Kip Twitchell

# This script initializes the CentOS vagrant environment with the following
# Elements needed to do z/OS Development
# (1) Update the OS upon initial startup
# (2) download wget for use in later commands
# (3) download and install Hercules System/370, ESA/390, and z/Architecture Emulator
# (4) download or use git respository version of MVS38j operating system
# (8) start Hercules

cd /home/vagrant
echo '****************************************************'
echo '************* update operating system  *************'
sudo yum -y update

echo '*********************************************'
echo '************* install wget ******************'
sudo yum -y install wget

echo '*********************************************'
echo '************* install wget ******************'
sudo yum -y install unzip

echo '******************************************************'
echo '************* download and install hercules **********'
wget http://www.hercules-390.org/hercules-3.07-1.x86_64.rpm
sudo yum -y install hercules-3.07-1.x86_64.rpm

echo '******************************************************'
echo '************* run ISO Mount for Turnkey MVS **********'

mkdir iplversion
cd iplversion
wget http://www.ibiblio.org/jmaynard/turnkey-mvs-3.zip
for z in *.zip; do unzip $z; done
cd /mnt
sudo mkdir tk3cd
sudo mount -t iso9660 -o loop /home/vagrant/iplversion/turnkey-mvs-3.iso /mnt/tk3cd
for z in *.zip; do unzip $z; done
cd tk3cd
./setup -as

echo '************************************************************************************'
echo '*****          Hercules VM for z installed, and Turnkey MVS as well          *******'
echo '** see instructions at http://www.bsp-gmbh.com/turnkey/cookbook/opmvs.html#MVSIPL **'
echo '** see instructions at http://www.bsp-gmbh.com/turnkey/cookbook/howto.html#LOGTSO **'
echo '************************************************************************************'

cd /home/vagrant/mvs38j
./startmvs
