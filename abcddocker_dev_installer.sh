#!/usr/bin/env bash

echo "*************************************"
echo "*Installing prerequisites           *"
echo "*************************************"
mkdir -p /usr/pubsw/packages/MMPS
mkdir -p /usr/pubsw/packages/matlab
mkdir -p /usr/pubsw/bin
mkdir -p /usr/pubsw/packages/spm/spm5b
mkdir -p /root/matlab/MMPS_nonsvn
cat << MAT > /root/matlab/startup.m
if ~isdeployed
  run('/usr/pubsw/packages/MMPS/startup_MMPS');
  addpath(sprintf('%s/matlab/MMPS_nonsvn',getenv('HOME')));
end
MAT
apt-get -qq update
apt-get install -qq --no-install-recommends apt-utils >/dev/null
apt-get -qq install tar tcsh libgl1-mesa-glx libglu1-mesa libxt6 >/dev/null
sed -e "s#^root.*#root:*:0:0:root:/root:/bin/tcsh#g" -i /etc/passwd
echo "*************************************"
echo "*Cleaning up                        *"
echo "*************************************"
apt-get -qq purge netbase manpages iputils-ping iproute2 gcc cpp cpp-6 gcc-6 >/dev/null
apt-get -qq autoremove >/dev/null
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
chmod -R 777 /tmp
