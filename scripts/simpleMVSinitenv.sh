#!/usr/bin/env bash

# * (c) Copyright IBM Corporation. 2019
# * SPDX-License-Identifier: Apache-2.0
# * By Kip Twitchell

# This script initializes the Aerospike/CentOS vagrant environment with the following
# Elements needed to do Scala development
# (1) Update the OS upon initial startup
# (2) download wget for use in later commands
# (3) download and install Hercules System/370, ESA/390, and z/Architecture Emulator
# (4) download or use git respository version of MVS38j operating system
# (5) download and install Java 8
# (6) download and install Scala 2.11 (to be potentially compatible with Spark if needed)
# (7) install sbt
# (8) start Hercules 

cd /home/vagrant
echo '****************************************************'
echo '************* update operating system  *************'
sudo yum -y update

echo '*********************************************'
echo '*************  install wget     *************'
sudo yum -y install wget

echo '*********************************************'
echo '************* install unzip     *************'
sudo yum -y install unzip

echo '******************************************************'
echo '************* download and install hercules **********'
mkdir tk4-
cd tk4-
wget http://wotho.ethz.ch/tk4-/tk4-_v1.00.zip

http://127.0.0.1:8038

echo '************************************************************************************'
echo '*****          Hercules VM for z installed, and TK4- MVS as well             *******'
echo '** see instructions at http://wotho.ethz.ch/tk4-/MVS_TK4-_v1.00_Users_Manual.pdf  **'
echo '**          console can be started via browser at http://127.0.0.1:8038           **'
echo '************************************************************************************'

cd /home/vagrant/tk4-
./mvs
