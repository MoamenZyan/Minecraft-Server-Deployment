#!/bin/bash

# Destroying Infrastructure 

gcloud compute instances delete minecraft-vm --zone us-central1-a --quiet

echo "********************************The instance has been deleted.************************************"

gcloud compute firewall-rules delete allow-ssh --quiet

echo "******************************The firewall has been deleted.***********************************"

gcloud compute networks subnets delete minecraft-subnet --region us-central1 --quiet

echo "****************************The subnet has been deleted.********************************"

gcloud compute networks delete minecraft-network --quiet

echo "********************************The network has been deleted.******************************"

gcloud compute disks delete my-disk --zone us-central1-a --quiet

echo "***********************************The disk has been deleted.********************************"

gcloud compute addresses delete mc-server-ip --region us-central1 --quiet

echo "*************************************The address has been deleted.********************************"

echo "Infrastructure has been destroyed successfully !!"
