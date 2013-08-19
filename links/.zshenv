#`.zshenv' is sourced on all invocations of the shell,
#unless the -f option is set. It should contain commands
#to set the command search path, plus other important
#environment variables. `.zshenv' should not contain
#commands that produce output or assume the shell
#is attached to a tty.

FPATH=/home/markus/.zshlib:$FPATH

# Highlight grep matches in green
GREP_OPTIONS='--color=auto'
GREP_COLOR='1;32'

#setopt cdablevars

#PATH=/opt/teambuilder/bin:$PATH:/opt/git/bin:${HOME}/bin:/usr/local/arm/2.95.3/bin:/opt/scilab-4.0/bin/:.
PATH=$PATH:${HOME}/bin


INFOPATH=$INFOPATH:/opt/git/share/info:/usr/local/arm/4.3.4/usr/info:/usr/local/arm/4.3.4/usr/share/info
eval $(lesspipe )
export GNUPGHOME=/home/gru/crypt/.gnupg
export LANG=en_GB.UTF-8
#export HTTP_PROXY=http://192.168.10.1:8000
export BC_ENV_ARGS="-q -l $HOME/.bc/myFunctions"
export CVSROOT=:pserver:gru@PT-AGCMLX1:/srv/cvs
export PTZDIR=~/vxp-ptz
export DEFAULT_VXPTEST_DESTINATION=10.1.2.34
export EMAIL=markus.grunwald@pruftechnik.com
export ORGANISATION="Pruftechnik AG"
#export C6000_C_DIR="/home/gru/OMAPL137_arm_1_00_00_11/cg6x_6_1_9/include;/home/gru/OMAPL137_arm_1_00_00_11/cg6x_6_1_9/lib"
#export C6000_C_DIR="/opt/ti/cg6x_6_1_9/include;/opt/ti/cg6x_6_1_9/lib"
#export C6X_C_DIR="/opt/ti/C6000CGT7.3.0/include;/opt/ti/C6000CGT7.3.0/lib"

#export XDCROOT=/opt/ti/xdctools_3_22_01_21


#export PATH=$PATH:/opt/mv_pro_5.0/montavista/pro/devkit/arm/v5t_le/bin:/opt/mv_pro_5.0/montavista/pro/bin:/opt/mv_pro_5.0/montavista/common/bin
#export PATH=$PATH:/opt/damian/toolchain/usr/bin
export PATH=$PATH:${XDCROOT}

export PATH=$PATH:.

#export SYSLINK_ROOT=/opt/ti/syslink_2_00_02_80

#. /opt/damian/toolchain/etc/icecc-damian-profile

export GTAGSLIBPATH=/opt/ti/ezsdk_5_05_02_00/component-sources/bios_6_33_05_46:/opt/ti/ezsdk_5_05_02_00/component-sources/edma3lld_02_11_05_02:/opt/ti/ezsdk_5_05_02_00/component-sources/ipc_1_24_03_32:/opt/ti/ezsdk_5_05_02_00/component-sources/syslink_2_20_02_20:/opt/ti/ezsdk_5_05_02_00/component-sources/xdctools_3_23_03_53:/opt/ti/c674x-dsplib:/opt/ti/C6000CGT

export RPROMPT='%~'
export GTK_IM_MODULE="xim"
#export DEPOT=/opt/ti/ezsdk_5.03.01.15

export T=/mnt/net/CM_Entwicklung
export X=/mnt/net/Xchg_Transfer
