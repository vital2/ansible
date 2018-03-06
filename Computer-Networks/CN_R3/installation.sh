#!/usr/bin/sh
############### snort installation #################

sudo apt install -y gcc g++ flex bison libpcap-dev libpcre3-dev autoconf libtool libdumbnet-dev zlib1g-dev pkg-config libssl-dev libpcre3-dev fwsnort
autoreconf -f -i
cd /home/student/
sudo wget https://www.snort.org/downloads/snort/daq-2.0.6.tar.gz
sudo wget https://www.snort.org/downloads/snort/snort-2.9.9.0.tar.gz
tar -xvzf daq-2.0.6.tar.gz
tar -xvzf snort-2.9.9.0.tar.gz

cd /home/student/snort_src/daq-2.0.6
./configure && make && sudo make install
cd /home/student/snort_src/snort-2.9.9.0
./configure && make && sudo make install

sudo ldconfig

sudo mkdir /etc/snort
sudo mkdir /etc/snort/preproc_rules
sudo mkdir /var/log/snort
sudo mkdir /usr/local/lib/snort_dynamicrules
sudo touch /etc/snort/rules/white_list.rules
sudo touch /etc/snort/rules/black_list.rules
sudo touch /etc/snort/rules/local.rules
sudo chmod -R 5775 /etc/snort/
sudo chmod -R 5775 /var/log/snort/
sudo chmod -R 5775 /usr/local/lib/snort
sudo chmod -R 5775 /usr/local/lib/snort_dynamicrules/
cd /home/student/snort_src/snort-2.9.9.0/etc
sudo cp -avr *.conf *.map *.dtd /etc/snort/
sudo cp -avr src/dynamic-preprocessors/build/usr/local/lib/snort_dynamicpreprocessor/* /usr/local/lib/snort_dynamicpreprocessor/

mv /home/student/snortrules-snapshot-2990.tar.gz /etc/snort
cd /etc/snort
tar xvfz snortrules-snapshot-2990.tar.gz

mkdir /home/student/InfectedPcaps
cp /home/student/infected.pcap /home/student/InfectedPcaps


############## quagga installation ###############

cd /usr/share/doc/quagga/examples
sudo chmod * 640
sudo rename 's/\.conf.sample$/\.conf/' *.conf.sample
sudo cp * /etc/quagga

