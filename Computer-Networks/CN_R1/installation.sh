#!/usr/bin/sh
############## quagga installation ###############
cd /usr/share/doc/quagga/examples
sudo chmod * 640
sudo rename 's/\.conf.sample$/\.conf/' *.conf.sample
sudo cp * /etc/quagga
