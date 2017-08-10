#!/bin/bash -eux

if [ -f /var/run/reboot-required ]; then
        reboot
fi

