#!/bin/bash

# Building Infrastructure & Start the minecraft server

gcloud config set project mohamedwaleed-we-training

gcloud compute networks create minecraft-network --subnet-mode custom --project mohamedwaleed-we-training

echo "********************The network has been created.***********************"

gcloud compute networks subnets create minecraft-subnet --network minecraft-network --region us-central1 --range 10.20.0.0/16

echo "************************************The subnet has been created.*******************************"

gcloud compute firewall-rules create allow-ssh --allow icmp,tcp:22,tcp:25565 --source-ranges 0.0.0.0/0 --network minecraft-network

echo "********************************The firewall has been created.***************************"

gcloud compute addresses create mc-server-ip --region us-central1

echo "**************************The address has been created.***************************"

gcloud compute disks create my-disk --size 50GB --type pd-ssd --zone us-central1-a

echo "***********************The disk has been created.************************"

gcloud compute instances create minecraft-vm --machine-type e2-standard-2 --subnet minecraft-subnet --zone us-central1-a --address mc-server-ip

echo "*****************************The instance has been created.********************************"

gcloud compute instances attach-disk minecraft-vm --disk my-disk --zone us-central1-a

echo "*****************************************The disk has been attached.***********************************"

sleep 30

gcloud compute ssh minecraft-vm --zone us-central1-a --command '
  sudo mkdir /home/minecraft/ && \
  sudo apt-get install -y default-jre-headless && \
  sudo mkfs.ext4 /dev/sdb && \
  sudo mount /dev/sdb /home/minecraft/ && \
  cd /home/minecraft/ && \
  sudo wget https://launcher.mojang.com/v1/objects/d0d0fe2b1dc6ab4c65554cb734270872b72dadd6/server.jar && \
  sudo java -Xmx1024M -Xms1024M -jar server.jar nogui && \
  sudo chmod 777 eula.txt && \
  echo "eula=true" | sudo cat > eula.txt && \
  sudo java -Xmx1024M -Xms1024M -jar server.jar nogui
'

