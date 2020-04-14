#!/usr/bin/env bash

# * (c) Copyright IBM Corporation. 2019
# * SPDX-License-Identifier: Apache-2.0
# * By Kip Twitchell

# This script initializes the CentOS vagrant environment with the following
# Elements needed to do scala Development
# (1) Update the OS upon initial startup
# (2) download wget for use in later commands
# (3) download and install Java 8
# (4) download and install Scala 2.11 (to be potentially compatible with Spark if needed)
# (5) install sbt

cd /home/vagrant
echo '****************************************************'
echo '************* update operating system  *************'
sudo yum -y update

echo '*********************************************'
echo '************* download and wget *************'
sudo yum -y install wget

cd /home/vagrant

echo '*******************************************************'
echo '************* download and install java 8 *************'

sudo yum -y install java-1.8.0-openjdk.x86_64
echo "java version:"
java -version
sudo yum -y install java-1.8.0-openjdk-devel.x86_64
echo "java compiler version:"
javac -version
sudo cp /etc/profile /etc/profile_backup  #Backup the profile file
echo 'export JAVA_HOME=/usr/lib/jvm/jre-openjdk' | sudo tee -a /etc/profile
echo 'export JRE_HOME=/usr/lib/jvm/jre' | sudo tee -a /etc/profile
source /etc/profile
echo 'Java home:'
echo $JAVA_HOME
echo 'JRE home:'
echo $JRE_HOME

echo '******************************************************'
echo '************* download and install scala *************'
# cd ~ # in the initial script, not sure it is needed
wget http://downloads.lightbend.com/scala/2.11.8/scala-2.11.8.rpm
sudo yum -y install scala-2.11.8.rpm
echo 'scala version:'
scala -version

#echo '****************************************************'
#echo '************* Initialize PostgreSQL DB *************'
#sudo /usr/pgsql-10/bin/postgresql-10-setup initdb

echo '************************************************'
echo '************* download/install sbt *************'
wget https://dl.bintray.com/sbt/rpm/sbt-0.13.16.rpm
sudo yum -y install sbt-0.13.16.rpm

echo '************************************************************************************'
echo '*****                   Java, Scala and sbt have been installed              *******'
echo '************************************************************************************'