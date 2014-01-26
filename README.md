Vagrant Chef Oracle Project
---------------------------

Vagrantfile to create (2) 64-bit Ubuntu Server-based Oracle/Java Development VMs with all applications other than an IDE, to build and test Java EE projects.

<h4>Major Components</h4>
* Oracle JDK 1.7.0_45-b18 64-bit for Linux x86-64 (apps vm)
* Oracle-related Environment variables (apps vm)
* WebLogic Server 12.1.2 (apps vm)
* (1) WLS domain / (1) WLS managed server (apps vm)

* Oracle Database Express Edition 11g Release 2 (11.2) for Linux x86-64 (dbs vm)

<h4>Required artifacts downloaded to separate 'chef-artifacts' repo in same parent folder</h4>
* *[jdk-7u45-linux-x64.tar.gz] (http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html)*
* *[wls_121200.jar] (http://www.oracle.com/technetwork/middleware/weblogic/downloads/wls-for-dev-1703574.html)*
* *[oracle-xe-11.2.0-1.0.x86_64.rpm.zip] (http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html)*

<h4>Ubuntu Cloud Image Used to Create VM</h4>
* *[Preferred: Ubuntu Server 13.10 (Saucy Salamander) 64-bit daily build] (http://cloud-images.ubuntu.com/vagrant/saucy/current/saucy-server-cloudimg-amd64-vagrant-disk1.box)*
* *[Alternate: Ubuntu Server 12.04 LTS (Precise Pangolin) 64-bit daily build] (http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box)*