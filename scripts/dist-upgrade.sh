#!/bin/bash -eux

if [ $1 == "true" ]; 
  then apt-get -y dist-upgrade
  else echo "apt-get dist-upgrade skipped - perform_dist_upgrade <> true."
fi

