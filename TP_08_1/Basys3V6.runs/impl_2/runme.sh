#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/local/xilinx-vivado/SDK/2018.2/bin:/local/xilinx-vivado/Vivado/2018.2/ids_lite/ISE/bin/lin64:/local/xilinx-vivado/Vivado/2018.2/bin
else
  PATH=/local/xilinx-vivado/SDK/2018.2/bin:/local/xilinx-vivado/Vivado/2018.2/ids_lite/ISE/bin/lin64:/local/xilinx-vivado/Vivado/2018.2/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=/local/xilinx-vivado/Vivado/2018.2/ids_lite/ISE/lib/lin64
else
  LD_LIBRARY_PATH=/local/xilinx-vivado/Vivado/2018.2/ids_lite/ISE/lib/lin64:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/home/m1/barchid/Desktop/AEO/Basys3V6/Basys3V6.runs/impl_2'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

# pre-commands:
/bin/touch .init_design.begin.rst
EAStep vivado -log Basys3V6.vdi -applog -m64 -product Vivado -messageDb vivado.pb -mode batch -source Basys3V6.tcl -notrace


