#!/bin/bash
#Author: Jesus Rosas
#Jenkins Slave configuration

setup_slave(){
    echo "[x] Adding users"
    sudo apt update
    sudo apt install default-jdk -y
    sudo apt-get install maven -y
    java --version
    mvn --version
    echo "[x] Adding users"
    sudo useradd -m jenkins
    sudo -u jenkins mkdir /home/jenkins/.ssh
    echo "[x] End of adding some users"
    #sudo cat ~/.ssh/id_rsa.pub -> Execute this on the server jenkins
    sudo -u jenkins vi /home/jenkins/.ssh/authorized_keys
    #Copy the id_rsa.pub file into that authorized
    echo "[x] End of the installation"
}
#Server command
#Execute at the end of the file - Ensure a directory is created
#sudo cp ~/.ssh/known_hosts  /var/lib/jenkins/.ssh/
#sudo chown jenkins:jenkins known_hosts
#Plugin for kubernetes
#kubernetes deploy

setup_slave