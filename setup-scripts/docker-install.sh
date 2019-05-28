#!/bin/sh

echo "##### Performing apt-get update #####"
sudo apt-get update
echo "##### Installing packages #####"
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "##### The Docker repo Key fingerprint should be: #####"
echo "9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88"
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
echo "##### Performing apt-get update #####"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo usermod -aG docker ubuntu
echo "##### Logging out -> in so that user added to docker group can perform docker operations #####"
