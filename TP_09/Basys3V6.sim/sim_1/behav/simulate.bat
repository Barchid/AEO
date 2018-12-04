@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xsim masterbench_behav -key {Behavioral:sim_1:Functional:masterbench} -tclbatch masterbench.tcl -view C:/Users/jld/nexys3V6_vivado/masterbench_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
