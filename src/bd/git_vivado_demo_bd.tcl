
################################################################
# This is a generated script based on design: git_vivado_demo_bd
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2019.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source git_vivado_demo_bd_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7vx690tffg1927-2
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name git_vivado_demo_bd

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:axi_pcie3:3.0\
xilinx.com:ip:smartconnect:1.0\
xilinx.com:ip:microblaze:11.0\
xilinx.com:ip:mig_7series:4.2\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:util_ds_buf:2.1\
xilinx.com:ip:mdm:3.2\
xilinx.com:ip:axi_intc:4.1\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:user:pcie_intc:1.0\
xilinx.com:ip:xadc_wiz:3.3\
xilinx.com:ip:lmb_bram_if_cntlr:4.0\
xilinx.com:ip:lmb_v10:3.0\
xilinx.com:ip:blk_mem_gen:8.4\
"

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}


##################################################################
# MIG PRJ FILE TCL PROCs
##################################################################

proc write_mig_file_git_vivado_demo_bd_mig_7series_0_0 { str_mig_prj_filepath } {

   file mkdir [ file dirname "$str_mig_prj_filepath" ]
   set mig_prj_file [open $str_mig_prj_filepath  w+]

   puts $mig_prj_file {ï»?<?xml version="1.0" encoding="UTF-8" standalone="no" ?>}
   puts $mig_prj_file {<Project NoOfControllers="1">}
   puts $mig_prj_file {  }
   puts $mig_prj_file {<!-- IMPORTANT: This is an internal file that has been generated by the MIG software. Any direct editing or changes made to this file may result in unpredictable behavior or data corruption. It is strongly advised that users do not edit the contents of this file. Re-run the MIG GUI with the required settings if any of the options provided below need to be altered. -->}
   puts $mig_prj_file {  <ModuleName>git_vivado_demo_bd_mig_7series_0_0</ModuleName>}
   puts $mig_prj_file {  <dci_inouts_inputs>1</dci_inouts_inputs>}
   puts $mig_prj_file {  <dci_inputs>1</dci_inputs>}
   puts $mig_prj_file {  <Debug_En>OFF</Debug_En>}
   puts $mig_prj_file {  <DataDepth_En>1024</DataDepth_En>}
   puts $mig_prj_file {  <LowPower_En>ON</LowPower_En>}
   puts $mig_prj_file {  <XADC_En>Disabled</XADC_En>}
   puts $mig_prj_file {  <TargetFPGA>xc7vx690t-ffg1927/-2</TargetFPGA>}
   puts $mig_prj_file {  <Version>4.2</Version>}
   puts $mig_prj_file {  <SystemClock>Differential</SystemClock>}
   puts $mig_prj_file {  <ReferenceClock>Use System Clock</ReferenceClock>}
   puts $mig_prj_file {  <SysResetPolarity>ACTIVE LOW</SysResetPolarity>}
   puts $mig_prj_file {  <BankSelectionFlag>FALSE</BankSelectionFlag>}
   puts $mig_prj_file {  <InternalVref>0</InternalVref>}
   puts $mig_prj_file {  <dci_hr_inouts_inputs>50 Ohms</dci_hr_inouts_inputs>}
   puts $mig_prj_file {  <dci_cascade>0</dci_cascade>}
   puts $mig_prj_file {  <Controller number="0">}
   puts $mig_prj_file {    <MemoryDevice>DDR3_SDRAM/Components/MT41J128M16XX-125</MemoryDevice>}
   puts $mig_prj_file {    <TimePeriod>1250</TimePeriod>}
   puts $mig_prj_file {    <VccAuxIO>2.0V</VccAuxIO>}
   puts $mig_prj_file {    <PHYRatio>4:1</PHYRatio>}
   puts $mig_prj_file {    <InputClkFreq>200</InputClkFreq>}
   puts $mig_prj_file {    <UIExtraClocks>0</UIExtraClocks>}
   puts $mig_prj_file {    <MMCM_VCO>800</MMCM_VCO>}
   puts $mig_prj_file {    <MMCMClkOut0> 1.000</MMCMClkOut0>}
   puts $mig_prj_file {    <MMCMClkOut1>1</MMCMClkOut1>}
   puts $mig_prj_file {    <MMCMClkOut2>1</MMCMClkOut2>}
   puts $mig_prj_file {    <MMCMClkOut3>1</MMCMClkOut3>}
   puts $mig_prj_file {    <MMCMClkOut4>1</MMCMClkOut4>}
   puts $mig_prj_file {    <DataWidth>64</DataWidth>}
   puts $mig_prj_file {    <DeepMemory>1</DeepMemory>}
   puts $mig_prj_file {    <DataMask>1</DataMask>}
   puts $mig_prj_file {    <ECC>Disabled</ECC>}
   puts $mig_prj_file {    <Ordering>Normal</Ordering>}
   puts $mig_prj_file {    <BankMachineCnt>8</BankMachineCnt>}
   puts $mig_prj_file {    <CustomPart>FALSE</CustomPart>}
   puts $mig_prj_file {    <NewPartName/>}
   puts $mig_prj_file {    <RowAddress>14</RowAddress>}
   puts $mig_prj_file {    <ColAddress>10</ColAddress>}
   puts $mig_prj_file {    <BankAddress>3</BankAddress>}
   puts $mig_prj_file {    <MemoryVoltage>1.5V</MemoryVoltage>}
   puts $mig_prj_file {    <C0_MEM_SIZE>1073741824</C0_MEM_SIZE>}
   puts $mig_prj_file {    <UserMemoryAddressMap>ROW_BANK_COLUMN</UserMemoryAddressMap>}
   puts $mig_prj_file {    <PinSelection>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="C15" SLEW="" VCCAUX_IO="HIGH" name="ddr3_addr[0]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="D15" SLEW="" VCCAUX_IO="HIGH" name="ddr3_addr[10]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="E12" SLEW="" VCCAUX_IO="HIGH" name="ddr3_addr[11]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="D12" SLEW="" VCCAUX_IO="HIGH" name="ddr3_addr[12]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="E14" SLEW="" VCCAUX_IO="HIGH" name="ddr3_addr[13]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="C14" SLEW="" VCCAUX_IO="HIGH" name="ddr3_addr[1]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="B15" SLEW="" VCCAUX_IO="HIGH" name="ddr3_addr[2]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="A15" SLEW="" VCCAUX_IO="HIGH" name="ddr3_addr[3]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="B13" SLEW="" VCCAUX_IO="HIGH" name="ddr3_addr[4]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="B12" SLEW="" VCCAUX_IO="HIGH" name="ddr3_addr[5]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="A14" SLEW="" VCCAUX_IO="HIGH" name="ddr3_addr[6]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="A13" SLEW="" VCCAUX_IO="HIGH" name="ddr3_addr[7]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="C13" SLEW="" VCCAUX_IO="HIGH" name="ddr3_addr[8]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="C12" SLEW="" VCCAUX_IO="HIGH" name="ddr3_addr[9]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="F15" SLEW="" VCCAUX_IO="HIGH" name="ddr3_ba[0]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="F14" SLEW="" VCCAUX_IO="HIGH" name="ddr3_ba[1]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="F13" SLEW="" VCCAUX_IO="HIGH" name="ddr3_ba[2]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="M13" SLEW="" VCCAUX_IO="HIGH" name="ddr3_cas_n"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="H14" SLEW="" VCCAUX_IO="HIGH" name="ddr3_ck_n[0]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="H15" SLEW="" VCCAUX_IO="HIGH" name="ddr3_ck_p[0]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="K14" SLEW="" VCCAUX_IO="HIGH" name="ddr3_cke[0]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="L13" SLEW="" VCCAUX_IO="HIGH" name="ddr3_cs_n[0]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="P20" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dm[0]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="M20" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dm[1]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="H19" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dm[2]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="A20" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dm[3]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="C17" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dm[4]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="J17" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dm[5]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="M17" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dm[6]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="U15" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dm[7]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="R21" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[0]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="J22" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[10]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="N19" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[11]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="L21" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[12]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="N20" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[13]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="K21" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[14]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="N22" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[15]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="J21" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[16]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="F21" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[17]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="J20" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[18]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="F20" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[19]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="P22" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[1]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="G20" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[20]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="F19" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[21]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="J19" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[22]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="H20" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[23]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="B21" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[24]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="D20" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[25]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="B20" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[26]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="D21" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[27]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="C20" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[28]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="E22" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[29]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="T21" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[2]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="A21" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[30]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="D22" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[31]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="A18" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[32]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="A16" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[33]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="A19" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[34]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="B16" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[35]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="C18" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[36]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="D17" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[37]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="B18" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[38]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="B17" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[39]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="P21" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[3]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="G18" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[40]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="E17" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[41]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="H17" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[42]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="F18" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[43]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="E16" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[44]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="E19" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[45]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="H18" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[46]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="E18" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[47]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="J16" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[48]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="N15" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[49]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="R22" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[4]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="L18" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[50]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="P15" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[51]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="K17" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[52]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="M16" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[53]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="M18" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[54]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="L16" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[55]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="R16" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[56]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="P16" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[57]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="V15" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[58]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="R18" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[59]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="R19" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[5]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="T16" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[60]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="T18" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[61]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="U18" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[62]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="R17" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[63]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="U20" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[6]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="T19" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[7]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="L20" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[8]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="M22" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dq[9]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="U21" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dqs_n[0]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="K19" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dqs_n[1]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="G22" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dqs_n[2]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="B22" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dqs_n[3]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="C19" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dqs_n[4]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="F16" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dqs_n[5]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="N17" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dqs_n[6]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="U16" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dqs_n[7]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="U22" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dqs_p[0]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="L19" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dqs_p[1]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="H22" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dqs_p[2]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="C22" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dqs_p[3]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="D19" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dqs_p[4]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="G16" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dqs_p[5]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="P17" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dqs_p[6]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="U17" SLEW="" VCCAUX_IO="HIGH" name="ddr3_dqs_p[7]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="L14" SLEW="" VCCAUX_IO="HIGH" name="ddr3_odt[0]"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="G12" SLEW="" VCCAUX_IO="HIGH" name="ddr3_ras_n"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="R14" SLEW="" VCCAUX_IO="HIGH" name="ddr3_reset_n"/>}
   puts $mig_prj_file {      <Pin IN_TERM="" IOSTANDARD="" PADName="H12" SLEW="" VCCAUX_IO="HIGH" name="ddr3_we_n"/>}
   puts $mig_prj_file {    </PinSelection>}
   puts $mig_prj_file {    <System_Clock>}
   puts $mig_prj_file {      <Pin Bank="38" PADName="J15/J14(CC_P/N)" name="sys_clk_p/n"/>}
   puts $mig_prj_file {    </System_Clock>}
   puts $mig_prj_file {    <System_Control>}
   puts $mig_prj_file {      <Pin Bank="17" PADName="A23" name="sys_rst"/>}
   puts $mig_prj_file {      <Pin Bank="Select Bank" PADName="No connect" name="init_calib_complete"/>}
   puts $mig_prj_file {      <Pin Bank="Select Bank" PADName="No connect" name="tg_compare_error"/>}
   puts $mig_prj_file {    </System_Control>}
   puts $mig_prj_file {    <TimingParameters>}
   puts $mig_prj_file {      <Parameters tcke="5" tfaw="40" tras="35" trcd="13.75" trefi="7.8" trfc="160" trp="13.75" trrd="7.5" trtp="7.5" twtr="7.5"/>}
   puts $mig_prj_file {    </TimingParameters>}
   puts $mig_prj_file {    <mrBurstLength name="Burst Length">8 - Fixed</mrBurstLength>}
   puts $mig_prj_file {    <mrBurstType name="Read Burst Type and Length">Sequential</mrBurstType>}
   puts $mig_prj_file {    <mrCasLatency name="CAS Latency">11</mrCasLatency>}
   puts $mig_prj_file {    <mrMode name="Mode">Normal</mrMode>}
   puts $mig_prj_file {    <mrDllReset name="DLL Reset">No</mrDllReset>}
   puts $mig_prj_file {    <mrPdMode name="DLL control for precharge PD">Slow Exit</mrPdMode>}
   puts $mig_prj_file {    <emrDllEnable name="DLL Enable">Enable</emrDllEnable>}
   puts $mig_prj_file {    <emrOutputDriveStrength name="Output Driver Impedance Control">RZQ/7</emrOutputDriveStrength>}
   puts $mig_prj_file {    <emrMirrorSelection name="Address Mirroring">Disable</emrMirrorSelection>}
   puts $mig_prj_file {    <emrCSSelection name="Controller Chip Select Pin">Enable</emrCSSelection>}
   puts $mig_prj_file {    <emrRTT name="RTT (nominal) - On Die Termination (ODT)">RZQ/4</emrRTT>}
   puts $mig_prj_file {    <emrPosted name="Additive Latency (AL)">0</emrPosted>}
   puts $mig_prj_file {    <emrOCD name="Write Leveling Enable">Disabled</emrOCD>}
   puts $mig_prj_file {    <emrDQS name="TDQS enable">Enabled</emrDQS>}
   puts $mig_prj_file {    <emrRDQS name="Qoff">Output Buffer Enabled</emrRDQS>}
   puts $mig_prj_file {    <mr2PartialArraySelfRefresh name="Partial-Array Self Refresh">Full Array</mr2PartialArraySelfRefresh>}
   puts $mig_prj_file {    <mr2CasWriteLatency name="CAS write latency">8</mr2CasWriteLatency>}
   puts $mig_prj_file {    <mr2AutoSelfRefresh name="Auto Self Refresh">Enabled</mr2AutoSelfRefresh>}
   puts $mig_prj_file {    <mr2SelfRefreshTempRange name="High Temparature Self Refresh Rate">Normal</mr2SelfRefreshTempRange>}
   puts $mig_prj_file {    <mr2RTTWR name="RTT_WR - Dynamic On Die Termination (ODT)">Dynamic ODT off</mr2RTTWR>}
   puts $mig_prj_file {    <PortInterface>AXI</PortInterface>}
   puts $mig_prj_file {    <AXIParameters>}
   puts $mig_prj_file {      <C0_C_RD_WR_ARB_ALGORITHM>RD_PRI_REG</C0_C_RD_WR_ARB_ALGORITHM>}
   puts $mig_prj_file {      <C0_S_AXI_ADDR_WIDTH>30</C0_S_AXI_ADDR_WIDTH>}
   puts $mig_prj_file {      <C0_S_AXI_DATA_WIDTH>512</C0_S_AXI_DATA_WIDTH>}
   puts $mig_prj_file {      <C0_S_AXI_ID_WIDTH>4</C0_S_AXI_ID_WIDTH>}
   puts $mig_prj_file {      <C0_S_AXI_SUPPORTS_NARROW_BURST>0</C0_S_AXI_SUPPORTS_NARROW_BURST>}
   puts $mig_prj_file {    </AXIParameters>}
   puts $mig_prj_file {  </Controller>}
   puts $mig_prj_file {</Project>}

   close $mig_prj_file
}
# End of write_mig_file_git_vivado_demo_bd_mig_7series_0_0()



##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: microblaze_0_local_memory
proc create_hier_cell_microblaze_0_local_memory { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_microblaze_0_local_memory() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 DLMB

  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 ILMB


  # Create pins
  create_bd_pin -dir I -type clk LMB_Clk
  create_bd_pin -dir I -type rst SYS_Rst

  # Create instance: dlmb_bram_if_cntlr, and set properties
  set dlmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 dlmb_bram_if_cntlr ]
  set_property -dict [ list \
   CONFIG.C_ECC {0} \
 ] $dlmb_bram_if_cntlr

  # Create instance: dlmb_v10, and set properties
  set dlmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 dlmb_v10 ]

  # Create instance: ilmb_bram_if_cntlr, and set properties
  set ilmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 ilmb_bram_if_cntlr ]
  set_property -dict [ list \
   CONFIG.C_ECC {0} \
 ] $ilmb_bram_if_cntlr

  # Create instance: ilmb_v10, and set properties
  set ilmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 ilmb_v10 ]

  # Create instance: lmb_bram, and set properties
  set lmb_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 lmb_bram ]
  set_property -dict [ list \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $lmb_bram

  # Create interface connections
  connect_bd_intf_net -intf_net microblaze_0_dlmb [get_bd_intf_pins DLMB] [get_bd_intf_pins dlmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_bus [get_bd_intf_pins dlmb_bram_if_cntlr/SLMB] [get_bd_intf_pins dlmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_cntlr [get_bd_intf_pins dlmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net microblaze_0_ilmb [get_bd_intf_pins ILMB] [get_bd_intf_pins ilmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_bus [get_bd_intf_pins ilmb_bram_if_cntlr/SLMB] [get_bd_intf_pins ilmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_cntlr [get_bd_intf_pins ilmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTB]

  # Create port connections
  connect_bd_net -net SYS_Rst_1 [get_bd_pins SYS_Rst] [get_bd_pins dlmb_bram_if_cntlr/LMB_Rst] [get_bd_pins dlmb_v10/SYS_Rst] [get_bd_pins ilmb_bram_if_cntlr/LMB_Rst] [get_bd_pins ilmb_v10/SYS_Rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins LMB_Clk] [get_bd_pins dlmb_bram_if_cntlr/LMB_Clk] [get_bd_pins dlmb_v10/LMB_Clk] [get_bd_pins ilmb_bram_if_cntlr/LMB_Clk] [get_bd_pins ilmb_v10/LMB_Clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_peri
proc create_hier_cell_hier_peri { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_hier_peri() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M02_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbdebug_rtl:3.0 MBDEBUG_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mbinterrupt_rtl:1.0 interrupt


  # Create pins
  create_bd_pin -dir I -type clk ACLK
  create_bd_pin -dir I -type rst ARESETN
  create_bd_pin -dir O -type rst Debug_SYS_Rst
  create_bd_pin -dir I -type clk M02_ACLK
  create_bd_pin -dir I -type rst M02_ARESETN
  create_bd_pin -dir I -from 5 -to 0 cfg_ltssm_state
  create_bd_pin -dir O intx_mis_request
  create_bd_pin -dir I intx_msi_grant
  create_bd_pin -dir I mis_enable
  create_bd_pin -dir O -from 4 -to 0 mis_vector_num
  create_bd_pin -dir I -from 2 -to 0 mis_vector_width
  create_bd_pin -dir I -type rst processor_rst
  create_bd_pin -dir O -from 11 -to 0 temp_out
  create_bd_pin -dir I user_link_up

  # Create instance: mdm_1, and set properties
  set mdm_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm_1 ]
  set_property -dict [ list \
   CONFIG.C_ADDR_SIZE {32} \
   CONFIG.C_M_AXI_ADDR_WIDTH {32} \
   CONFIG.C_USE_UART {1} \
 ] $mdm_1

  # Create instance: microblaze_0_axi_intc, and set properties
  set microblaze_0_axi_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 microblaze_0_axi_intc ]
  set_property -dict [ list \
   CONFIG.C_HAS_FAST {1} \
 ] $microblaze_0_axi_intc

  # Create instance: microblaze_0_axi_periph, and set properties
  set microblaze_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 microblaze_0_axi_periph ]
  set_property -dict [ list \
   CONFIG.NUM_MI {5} \
 ] $microblaze_0_axi_periph

  # Create instance: microblaze_0_xlconcat, and set properties
  set microblaze_0_xlconcat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 microblaze_0_xlconcat ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {1} \
 ] $microblaze_0_xlconcat

  # Create instance: pcie_intc_0, and set properties
  set pcie_intc_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:pcie_intc:1.0 pcie_intc_0 ]

  # Create instance: xadc_wiz_0, and set properties
  set xadc_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_0 ]
  set_property -dict [ list \
   CONFIG.ENABLE_TEMP_BUS {true} \
 ] $xadc_wiz_0

  # Create interface connections
  connect_bd_intf_net -intf_net microblaze_0_axi_dp [get_bd_intf_pins S00_AXI] [get_bd_intf_pins microblaze_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M02_AXI [get_bd_intf_pins M02_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M03_AXI [get_bd_intf_pins microblaze_0_axi_periph/M03_AXI] [get_bd_intf_pins pcie_intc_0/S00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M04_AXI [get_bd_intf_pins microblaze_0_axi_periph/M04_AXI] [get_bd_intf_pins xadc_wiz_0/s_axi_lite]
  connect_bd_intf_net -intf_net microblaze_0_debug [get_bd_intf_pins MBDEBUG_0] [get_bd_intf_pins mdm_1/MBDEBUG_0]
  connect_bd_intf_net -intf_net microblaze_0_intc_axi [get_bd_intf_pins microblaze_0_axi_intc/s_axi] [get_bd_intf_pins microblaze_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_interrupt [get_bd_intf_pins interrupt] [get_bd_intf_pins microblaze_0_axi_intc/interrupt]
  connect_bd_intf_net -intf_net microblaze_0_mdm_axi [get_bd_intf_pins mdm_1/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M01_AXI]

  # Create port connections
  connect_bd_net -net axi_pcie3_0_axi_aclk [get_bd_pins M02_ACLK] [get_bd_pins microblaze_0_axi_periph/M02_ACLK]
  connect_bd_net -net axi_pcie3_0_axi_aresetn [get_bd_pins M02_ARESETN] [get_bd_pins microblaze_0_axi_periph/M02_ARESETN]
  connect_bd_net -net axi_pcie3_0_cfg_ltssm_state [get_bd_pins cfg_ltssm_state] [get_bd_pins pcie_intc_0/cfg_ltssm_state]
  connect_bd_net -net axi_pcie3_0_intx_msi_grant [get_bd_pins intx_msi_grant] [get_bd_pins pcie_intc_0/intx_msi_grant]
  connect_bd_net -net axi_pcie3_0_msi_enable [get_bd_pins mis_enable] [get_bd_pins pcie_intc_0/mis_enable]
  connect_bd_net -net axi_pcie3_0_msi_vector_width [get_bd_pins mis_vector_width] [get_bd_pins pcie_intc_0/mis_vector_width]
  connect_bd_net -net axi_pcie3_0_user_link_up [get_bd_pins user_link_up] [get_bd_pins pcie_intc_0/user_link_up]
  connect_bd_net -net mdm_1_Interrupt [get_bd_pins mdm_1/Interrupt] [get_bd_pins microblaze_0_xlconcat/In0]
  connect_bd_net -net mdm_1_debug_sys_rst [get_bd_pins Debug_SYS_Rst] [get_bd_pins mdm_1/Debug_SYS_Rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins ACLK] [get_bd_pins mdm_1/S_AXI_ACLK] [get_bd_pins microblaze_0_axi_intc/processor_clk] [get_bd_pins microblaze_0_axi_intc/s_axi_aclk] [get_bd_pins microblaze_0_axi_periph/ACLK] [get_bd_pins microblaze_0_axi_periph/M00_ACLK] [get_bd_pins microblaze_0_axi_periph/M01_ACLK] [get_bd_pins microblaze_0_axi_periph/M03_ACLK] [get_bd_pins microblaze_0_axi_periph/M04_ACLK] [get_bd_pins microblaze_0_axi_periph/S00_ACLK] [get_bd_pins pcie_intc_0/s00_axi_aclk] [get_bd_pins xadc_wiz_0/s_axi_aclk]
  connect_bd_net -net microblaze_0_intr [get_bd_pins microblaze_0_axi_intc/intr] [get_bd_pins microblaze_0_xlconcat/dout]
  connect_bd_net -net pcie_intc_0_intx_mis_request [get_bd_pins intx_mis_request] [get_bd_pins pcie_intc_0/intx_mis_request]
  connect_bd_net -net pcie_intc_0_mis_vector_num [get_bd_pins mis_vector_num] [get_bd_pins pcie_intc_0/mis_vector_num]
  connect_bd_net -net rst_mig_7series_0_200M_mb_reset [get_bd_pins processor_rst] [get_bd_pins microblaze_0_axi_intc/processor_rst]
  connect_bd_net -net rst_mig_7series_0_200M_peripheral_aresetn [get_bd_pins ARESETN] [get_bd_pins mdm_1/S_AXI_ARESETN] [get_bd_pins microblaze_0_axi_intc/s_axi_aresetn] [get_bd_pins microblaze_0_axi_periph/ARESETN] [get_bd_pins microblaze_0_axi_periph/M00_ARESETN] [get_bd_pins microblaze_0_axi_periph/M01_ARESETN] [get_bd_pins microblaze_0_axi_periph/M03_ARESETN] [get_bd_pins microblaze_0_axi_periph/M04_ARESETN] [get_bd_pins microblaze_0_axi_periph/S00_ARESETN] [get_bd_pins pcie_intc_0/s00_axi_aresetn] [get_bd_pins xadc_wiz_0/s_axi_aresetn]
  connect_bd_net -net xadc_wiz_0_temp_out [get_bd_pins temp_out] [get_bd_pins xadc_wiz_0/temp_out]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR3_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR3_0 ]

  set ddr_ref_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 ddr_ref_clk ]

  set pcie_7x_mgt_rtl_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:pcie_7x_mgt_rtl:1.0 pcie_7x_mgt_rtl_0 ]

  set pcie_ref_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 pcie_ref_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {100000000} \
   ] $pcie_ref_clk


  # Create ports
  set sys_nrst [ create_bd_port -dir I -type rst sys_nrst ]

  # Create instance: axi_pcie3_0, and set properties
  set axi_pcie3_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_pcie3:3.0 axi_pcie3_0 ]
  set_property -dict [ list \
   CONFIG.axi_data_width {64_bit} \
   CONFIG.axisten_freq {250} \
   CONFIG.dedicate_perst {false} \
   CONFIG.en_axi_slave_if {false} \
   CONFIG.pcie_blk_locn {X0Y1} \
   CONFIG.pf0_device_id {7024} \
   CONFIG.pl_link_cap_max_link_speed {5.0_GT/s} \
   CONFIG.pl_link_cap_max_link_width {X4} \
   CONFIG.plltype {QPLL1} \
 ] $axi_pcie3_0

  # Create instance: axi_smc, and set properties
  set axi_smc [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_smc ]
  set_property -dict [ list \
   CONFIG.NUM_CLKS {2} \
   CONFIG.NUM_SI {1} \
 ] $axi_smc

  # Create instance: hier_peri
  create_hier_cell_hier_peri [current_bd_instance .] hier_peri

  # Create instance: microblaze_0, and set properties
  set microblaze_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0 ]
  set_property -dict [ list \
   CONFIG.C_DEBUG_ENABLED {1} \
   CONFIG.C_D_AXI {1} \
   CONFIG.C_D_LMB {1} \
   CONFIG.C_I_LMB {1} \
   CONFIG.G_TEMPLATE_LIST {8} \
 ] $microblaze_0

  # Create instance: microblaze_0_local_memory
  create_hier_cell_microblaze_0_local_memory [current_bd_instance .] microblaze_0_local_memory

  # Create instance: mig_7series_0, and set properties
  set mig_7series_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mig_7series:4.2 mig_7series_0 ]

  # Generate the PRJ File for MIG
  set str_mig_folder [get_property IP_DIR [ get_ips [ get_property CONFIG.Component_Name $mig_7series_0 ] ] ]
  set str_mig_file_name mig_a.prj
  set str_mig_file_path ${str_mig_folder}/${str_mig_file_name}

  write_mig_file_git_vivado_demo_bd_mig_7series_0_0 $str_mig_file_path

  set_property -dict [ list \
   CONFIG.BOARD_MIG_PARAM {Custom} \
   CONFIG.MIG_DONT_TOUCH_PARAM {Custom} \
   CONFIG.RESET_BOARD_INTERFACE {Custom} \
   CONFIG.XML_INPUT_FILE {mig_a.prj} \
 ] $mig_7series_0

  # Create instance: rst_mig_7series_0_200M, and set properties
  set rst_mig_7series_0_200M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_mig_7series_0_200M ]

  # Create instance: util_ds_buf, and set properties
  set util_ds_buf [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 util_ds_buf ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IBUFDSGTE} \
 ] $util_ds_buf

  # Create interface connections
  connect_bd_intf_net -intf_net SYS_CLK_0_1 [get_bd_intf_ports ddr_ref_clk] [get_bd_intf_pins mig_7series_0/SYS_CLK]
  connect_bd_intf_net -intf_net axi_pcie3_0_M_AXI [get_bd_intf_pins axi_pcie3_0/M_AXI] [get_bd_intf_pins axi_smc/S00_AXI]
  connect_bd_intf_net -intf_net axi_pcie3_0_pcie_7x_mgt [get_bd_intf_ports pcie_7x_mgt_rtl_0] [get_bd_intf_pins axi_pcie3_0/pcie_7x_mgt]
  connect_bd_intf_net -intf_net axi_smc_M00_AXI [get_bd_intf_pins axi_smc/M00_AXI] [get_bd_intf_pins mig_7series_0/S_AXI]
  connect_bd_intf_net -intf_net diff_clock_rtl_0_1 [get_bd_intf_ports pcie_ref_clk] [get_bd_intf_pins util_ds_buf/CLK_IN_D]
  connect_bd_intf_net -intf_net microblaze_0_axi_dp [get_bd_intf_pins hier_peri/S00_AXI] [get_bd_intf_pins microblaze_0/M_AXI_DP]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M02_AXI [get_bd_intf_pins axi_pcie3_0/S_AXI_CTL] [get_bd_intf_pins hier_peri/M02_AXI]
  connect_bd_intf_net -intf_net microblaze_0_debug [get_bd_intf_pins hier_peri/MBDEBUG_0] [get_bd_intf_pins microblaze_0/DEBUG]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_1 [get_bd_intf_pins microblaze_0/DLMB] [get_bd_intf_pins microblaze_0_local_memory/DLMB]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_1 [get_bd_intf_pins microblaze_0/ILMB] [get_bd_intf_pins microblaze_0_local_memory/ILMB]
  connect_bd_intf_net -intf_net microblaze_0_interrupt [get_bd_intf_pins hier_peri/interrupt] [get_bd_intf_pins microblaze_0/INTERRUPT]
  connect_bd_intf_net -intf_net mig_7series_0_DDR3 [get_bd_intf_ports DDR3_0] [get_bd_intf_pins mig_7series_0/DDR3]

  # Create port connections
  connect_bd_net -net axi_pcie3_0_axi_aclk [get_bd_pins axi_pcie3_0/axi_aclk] [get_bd_pins axi_smc/aclk] [get_bd_pins hier_peri/M02_ACLK]
  connect_bd_net -net axi_pcie3_0_axi_aresetn [get_bd_pins axi_pcie3_0/axi_aresetn] [get_bd_pins hier_peri/M02_ARESETN]
  connect_bd_net -net axi_pcie3_0_cfg_ltssm_state [get_bd_pins axi_pcie3_0/cfg_ltssm_state] [get_bd_pins hier_peri/cfg_ltssm_state]
  connect_bd_net -net axi_pcie3_0_intx_msi_grant [get_bd_pins axi_pcie3_0/intx_msi_grant] [get_bd_pins hier_peri/intx_msi_grant]
  connect_bd_net -net axi_pcie3_0_msi_enable [get_bd_pins axi_pcie3_0/msi_enable] [get_bd_pins hier_peri/mis_enable]
  connect_bd_net -net axi_pcie3_0_msi_vector_width [get_bd_pins axi_pcie3_0/msi_vector_width] [get_bd_pins hier_peri/mis_vector_width]
  connect_bd_net -net axi_pcie3_0_user_link_up [get_bd_pins axi_pcie3_0/user_link_up] [get_bd_pins hier_peri/user_link_up]
  connect_bd_net -net mdm_1_debug_sys_rst [get_bd_pins hier_peri/Debug_SYS_Rst] [get_bd_pins rst_mig_7series_0_200M/mb_debug_sys_rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins axi_smc/aclk1] [get_bd_pins hier_peri/ACLK] [get_bd_pins microblaze_0/Clk] [get_bd_pins microblaze_0_local_memory/LMB_Clk] [get_bd_pins mig_7series_0/ui_clk] [get_bd_pins rst_mig_7series_0_200M/slowest_sync_clk]
  connect_bd_net -net mig_7series_0_mmcm_locked [get_bd_pins mig_7series_0/mmcm_locked] [get_bd_pins rst_mig_7series_0_200M/dcm_locked]
  connect_bd_net -net mig_7series_0_ui_clk_sync_rst [get_bd_pins mig_7series_0/ui_clk_sync_rst] [get_bd_pins rst_mig_7series_0_200M/ext_reset_in]
  connect_bd_net -net pcie_intc_0_intx_mis_request [get_bd_pins axi_pcie3_0/intx_msi_request] [get_bd_pins hier_peri/intx_mis_request]
  connect_bd_net -net pcie_intc_0_mis_vector_num [get_bd_pins axi_pcie3_0/msi_vector_num] [get_bd_pins hier_peri/mis_vector_num]
  connect_bd_net -net rst_mig_7series_0_200M_bus_struct_reset [get_bd_pins microblaze_0_local_memory/SYS_Rst] [get_bd_pins rst_mig_7series_0_200M/bus_struct_reset]
  connect_bd_net -net rst_mig_7series_0_200M_mb_reset [get_bd_pins hier_peri/processor_rst] [get_bd_pins microblaze_0/Reset] [get_bd_pins rst_mig_7series_0_200M/mb_reset]
  connect_bd_net -net rst_mig_7series_0_200M_peripheral_aresetn [get_bd_pins axi_smc/aresetn] [get_bd_pins hier_peri/ARESETN] [get_bd_pins mig_7series_0/aresetn] [get_bd_pins rst_mig_7series_0_200M/peripheral_aresetn]
  connect_bd_net -net sys_rst_0_1 [get_bd_ports sys_nrst] [get_bd_pins axi_pcie3_0/sys_rst_n] [get_bd_pins mig_7series_0/sys_rst]
  connect_bd_net -net util_ds_buf_IBUF_OUT [get_bd_pins axi_pcie3_0/refclk] [get_bd_pins util_ds_buf/IBUF_OUT]
  connect_bd_net -net xadc_wiz_0_temp_out [get_bd_pins hier_peri/temp_out] [get_bd_pins mig_7series_0/device_temp_i]

  # Create address segments
  assign_bd_address -offset 0x80000000 -range 0x40000000 -target_address_space [get_bd_addr_spaces axi_pcie3_0/M_AXI] [get_bd_addr_segs mig_7series_0/memmap/memaddr] -force
  assign_bd_address -offset 0x10000000 -range 0x10000000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_pcie3_0/S_AXI_CTL/CTL0] -force
  assign_bd_address -offset 0x00000000 -range 0x00004000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_local_memory/dlmb_bram_if_cntlr/SLMB/Mem] -force
  assign_bd_address -offset 0x00000000 -range 0x00004000 -target_address_space [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs microblaze_0_local_memory/ilmb_bram_if_cntlr/SLMB/Mem] -force
  assign_bd_address -offset 0x41400000 -range 0x00001000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs hier_peri/mdm_1/S_AXI/Reg] -force
  assign_bd_address -offset 0x41200000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs hier_peri/microblaze_0_axi_intc/S_AXI/Reg] -force
  assign_bd_address -offset 0x44A00000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs hier_peri/pcie_intc_0/S00_AXI/S00_AXI_reg] -force
  assign_bd_address -offset 0x44A10000 -range 0x00010000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs hier_peri/xadc_wiz_0/s_axi_lite/Reg] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


