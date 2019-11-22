#!/bin/sh

#Create a loopback
#Change the IP alias to your container instance
sudo ifconfig lo0 alias 172.17.0.3
sudo ifconfig lo0 alias 172.17.0.6
sudo ifconfig lo0 alias 172.17.0.10

#Removing a loopback
#sudo ifconfig lo0 -alias 172.17.0.3

#Reroute docker conterner redis_master IP, redirect connection from docker IP 172.17.0.3:6379 to 0.0.0.0:7000
ncat --sh-exec "ncat 0.0.0.0 7000" -l 172.17.0.3 6379 --keep-open &

#Reroute docker redis_slave IP, redirect connection 
ncat --sh-exec "ncat 0.0.0.0 5002" -l 172.17.0.6 6379 --keep-open &
ncat --sh-exec "ncat 0.0.0.0 5003" -l 172.17.0.10 6379 --keep-open &