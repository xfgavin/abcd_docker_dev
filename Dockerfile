# Create a base abcd docker container 
#
# Note: The resulting container is ~8GB. 
# 
# Example build:
#   docker build --no-cache -t abcd:251 .
#
# Example usage:
#   docker run -ti \
#       -v /input/directory:/input \
#       -v `/output/directory:/output \
#       abcd:251 \
#       mri_convert -at /input/inputvolume.m3z /output/outvolume.mgz
#

# Start with debian
FROM debian
MAINTAINER Feng Xue <xfgavin@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

ADD abcddocker_dev_installer.sh /tmp

RUN /tmp/abcddocker_dev_installer.sh
ADD *.csh /usr/pubsw/bin/
ADD .cshrc /root/


ENV NAME "MMPS Compiler"
ENV VER "R2014b"
#############################################################################
#The entrypoint_gosu.sh will creat an MMPS user with uid equals current user
#So data should be mounted to /home/MMPS
#############################################################################

#ENTRYPOINT ["/usr/pubsw/packages/MMPS/MMPS_251/sh/abcd_init.sh"]
ENV DEBIAN_FRONTEND teletype
