###############################################################################
set histfile = /tmp/histfile
### Default software/script locations
setenv PUBSW /usr/pubsw    ### Override the default pubsw location here
setenv PUBSH /usr/pubsw    ### Override the default SetUp*.csh files here

###############################################################################
### Default path additions
set addpathlist = ( \
$PUBSH/bin \
~/bin \
./ \
)
foreach dir ( $addpathlist )
  if ("$path" !~ *$dir*) set path = ($dir $path)
end
unset addpathlist dir

###############################################################################
### common shell variables
set system=`hostname`       # name of this system.
set cpu=`uname -m`
limit coredumpsize 0
###############################################################################
### custom aliases
if ( -e ~/.alias ) then
  source ~/.alias
endif

###############################################################################
### Setup standard software environment.
### Override by setting $PUBSH to point somewhere else or specify path to
### specific setup file.
#source $PUBSH/bin/SetUpFreeSurfer.csh 530
#source $PUBSH/bin/SetUpAFNI.csh 2008_02_01_1144
#source $PUBSH/bin/SetUpAFNI.csh 2011_12_21_1014
#source $PUBSH/bin/SetUpAFNI.csh 2010_10_19_1028
#source $PUBSH/bin/SetUpFSL.csh 5.0.2.2-centos5_64
source $PUBSH/bin/SetUpMMPS.csh 251
#source $PUBSH/bin/SetUpMMPS.csh DEV
#if (-e $PUBSH/bin/SetUpCamino.csh) then
#  source $PUBSH/bin/SetUpCamino.csh
#endif
#source ~/bin/SetUpCamino.csh

###############################################################################

  source $PUBSH/bin/SetUpMatlab.csh R2014b

###############################################################################
set path=`echo $path | awk '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=" "}}}'`

###############################################################################
### Set the default umask for file permissions 
umask 022
