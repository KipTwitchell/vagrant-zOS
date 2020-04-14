# Vagrant-z/OS Project

This project builds a z/OS Hercules environment inside a Vagrant Box for easy setup and destruction.

Other development tools, such as Java, Scala and the scala build tool sbt can easily be added to the Vagrant environment.

# Hercules
"Hercules is an open source software implementation of the mainframe System/370 and ESA/390 architectures, in addition to the new 64-bit z/Architecture. Hercules runs under Linux, Windows (98, NT, 2000, and XP), Solaris, FreeBSD, and Mac OS X (10.3 and later)."

Hercules does not include the z/OS operating system, but is a VM itself.  It does not require Vagrant as a container, and can likely run on the operating system of the machine you have chosen (Linux, Windows or Mac).  Vagrant is simply added here to make the installation process easier, repeatable, and to isolate all configuration from your local machine.

You can read more about Hercules here:  http://www.hercules-390.org

# Operating System
There are two forms of "turnkey" z/OS installations available in this project:
 1) The SimpleMVS version I think is the easiest to use.  I happened to have discovered it last though (thus a second is included in the project).  It's documentation is a little less comprehensive, but the startup is very simple.  You can read more about it here: http://wotho.ethz.ch/tk4-/
 2) The IPL version is a larger download, and the user is required to enter the commands to actually IPL the operating system.  You can read more about it here: http://www.bsp-gmbh.com/turnkey/herc_mvs.html
  
# Technologies

This project uses the following technologies:

(1) Vagrant as the VM container (which relies up Virtualbox or other similar technology)

(2) CentOS as the Linux Distro (no specific reason for this Distro)

(3) Hercules VM inside the Vagrant Container

(4) One of the two MVS OS implementations

I have left scripting in place to install other development tools in the Vagrant (not Hercules) VM environment if desired using the javaScalainitenv.sh script in the project's script directory.  It will download and install:

(5) Java development environment

(6) Scala as the development language

(7) sbt as the build manager for Scala

# Vagrant Setup

The project can be used by doing the following:

(1) Download and install Vagrant https://www.vagrantup.com/downloads.html

(2) Download and install Virtualbox https://www.virtualbox.org

(3) Replicate this git project to your hard disk

(4) At a command prompt within the root directory of this project, (the directory that contains the Vagrantfile) 

(a) Install Vagrant Virtual Box Guest Additions by typing (this step is not tested)
    
    vagrant plugin install vagrant-vbguest
    
    and then
    
    vagrant vbguest
    
    (if you receive a message about "Vagrant was unable to mount VirtualBox shared folders. This is usually because the filesystem "vboxsf" is not available." then use the command "vagrant vbguest --status" to see if something is wrong with this installation)

(b) Start the virtual box by typing 
    
    vagrant up

(5) When that is complete, type "vagrant ssh" which will put you inside the vagrant VM.

(6) change directory to /vagrant-zos/scripts

# SimpleMVS.sh

If you choose the simple implementation, use the bash script to initial Hercules and the operating system, by typing "bash ./simpleMVSinitenv.sh"

This script will:
 (1) Update the operating system
 (2) Download and install Hercules
 (3) Download and install the tk4- MVS 3.8j operating system
 
 This script will automatically start the mvs environment.  
 
 The Vagrant script forwards communication on ports 3270 and 8038 to the host. 
 
 A 3270 emulator will be required to access the system.  The emulator should be pointed to address 127.0.0.1, and port 3270.  
 
 When connected to the system, use the "Clear" key to be presented with a log on.  There are multiple user IDs set up, but one can simply use HERC01 with a password of CUL8TR to access the system.
 
 Shutdown can be accomplished from the 3270 emulator by exiting (often PF3) from the editing environment and typing "shutdown" at the TSO prompt.  
 
 The 8038 port can be used to access the console via a browser at:   http://127.0.0.1:8038
 
 After the first time setup, the operating system can be started by
 (1) starting Vagrant with the "vagrant up" command
 (2) "vagrant ssh" into the Vagrant environment
 (3) "cd tk4-" to moved from the home (home/vagrant) director the installed location of the operating sytem
 (4) typing "./mvs" to start the operating system.

 Additional instructions can be located here:  http://wotho.ethz.ch/tk4-/ 
 
 # IPLinitennv.sh
 
Although you can do the IPL steps manually with the above configuration, (see documentation) they are required with the "turnkey" version implemented by the IPL Script.  

If you choose this implementation, use the bash script to initial Hercules and the operating system, by typing "bash ./IPLinitenv.sh"

This script will:
 (1) Update the operating system
 (2) Download and install Hercules
 (3) Download and install the tk4- MVS 3.8j operating system
 
 This script will automatically start the mvs environment.  
 
 The Vagrant script forwards communication on ports 3270 to the host (this system does not have a web browser console to access). 
 
 A 3270 emulator will be required to access the system.  The emulator should be pointed to address 127.0.0.1, and port 3270.
 
 After opening the emulators, in the unix command prompt (now showing the running operating system) type "ipl 148" and hit enter  
 
 The 3720 screen that is "Device 10" will be the console.  In this screen, once the system starts, use the steps in this document to IPL the system: http://www.bsp-gmbh.com/turnkey/cookbook/opmvs.html#MVSIPL

 Once the operating system is IPLed, use the steps in this document to log on to TSO sessions:  http://www.bsp-gmbh.com/turnkey/cookbook/howto.html#LOGTSO

 A hard stop of the system can be accomplished by typing "exit" at the Unix Command prompt, which will stop the system rapidly.
 
  After the first time setup, the operating system can be started by
  (1) starting Vagrant with the "vagrant up" command
  (2) "vagrant ssh" into the Vagrant environment
  (3) "cd mvs38j" to moved from the home (home/vagrant) director the installed location of the operating sytem
  (4) typing "./startmvs" to start the operating system.
  
Additional Information is availble here: http://www.bsp-gmbh.com/turnkey/herc_mvs.html

 # Teardown
 
 The above script can be used to reset the environment if one frist destroys the vagrant environment.  To do this:
 
 (0) if you are at the sbt prompt, you need to hit control-C to get back to Vagarnt ssh prompt
 
 (1) Type "Exit" to exit the VM shell environment
 
 (2) Within the VagrantFile directory, type "vagrant destroy"
 
 (3) Confirm the choice to destroy the vagrant environment.
 
 (4) To rebuild the environment start again with the "Vagrant up" command.
    
# Legal
 
 Each source file must include a license header for the Apache Software License 2.0. Using the SPDX format is the simplest approach. e.g.
 
` /*`
`  Copyright <holder> All Rights Reserved.`
` ` 
`  SPDX-License-Identifier: Apache-2.0
`
`  */`
 
 We have tried to make it as easy as possible to make contributions. This applies to how we handle the legal aspects of contribution. We use the same approach - the Developer's Certificate of Origin 1.1 (DCO) - that the Linux® Kernel community uses to manage code contributions.
 
 We simply ask that when submitting a patch for review, the developer must include a sign-off statement in the commit message.
 
 Here is an example Signed-off-by line, which indicates that the submitter accepts the DCO:
 
 Signed-off-by: John Doe <john.doe@example.com>
 You can include this automatically when you commit a change to your local git repository using the following command:
 
 `git commit -s` 