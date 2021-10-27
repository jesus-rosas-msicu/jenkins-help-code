#!/bin/bash
#Author Jesus Rosas
#Install jenkins with openssl
#Reference
#https://medium.com/tech-insider/jenkins-installation-and-setup-from-scratch-on-linux-5d9746b11fce
#https://laptrinhx.com/how-to-setup-jenkins-with-ssl-with-apache-reverse-proxy-on-ubuntu-18-04-1447266611/

install_jenkins(){
    echo "[x] Updating the system"
    sudo apt update
    echo "[x] installing openjdk"
    sudo apt-get install openjdk-8-jre openjdk-8-jdk
    wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
    sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt update
    echo "[x] Installing Jenkins"
    sudo apt install jenkins -y
    echo "[x] Service started"
    sudo service jenkins status
}

setup_jenkins_ssl(){
    echo "[x] Update Jenkins"
    sudo apt update
    echo "[x] Installing apache2"
    sudo apt install apache2 -y 
    echo "[x] Enabling modules"
    sudo a2enmod proxy
    sudo a2enmod proxy_http
    sudo a2enmod headers
    sudo a2enmod rewrite
    echo "[X] Disabling the default configuration"
    sudo a2dissite 000-default
    echo "[x] Copying configuration"
    sudo cp jenkins.conf /etc/apache2/sites-available/
    echo "[x] Enabling the site"
    sudo a2ensite jenkins.conf
    echo "[x] Configuring Jenkins file"
    echo 'JENKINS_ARGS="--webroot=/var/cache/$NAME/war --httpPort=$HTTP_PORT --httpListenAddress=127.0.0.1' >> /etc/default/jenkins
    sudo service jenkins restart
    echo "[x] Restaring apache2 and checking configuration"
    sudo apachectl configtest
    sudo service apache restart
    echo "[x] Install let0s encrypt"
    sudo add-apt-repository ppa:certbot/certbot
    sudo apt update
    sudo apt install python-certbot-apache
    echo "[X] Generating a certificate"
    sudo certbot --apache -m <Email> -d domain.com -d www.domain.com -d jenkins.domain.com
}

install_jenkins
setup_jenkins_ssl
