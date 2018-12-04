#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2018.2.1 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Tue Dec 04 19:03:42 CET 2018
# SW Build 2288692 on Thu Jul 26 18:23:50 MDT 2018
#
# Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep xelab -wto 5aa5c1fd80664393b166ba088d358cd5 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L secureip -L xpm --snapshot IP_fibo_behav xil_defaultlib.IP_fibo -log elaborate.log
