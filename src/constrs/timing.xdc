set_false_path -from [get_ports sys_nrst]
create_clock -period 10.000 -name sys_clk [get_ports pcie_ref_clk_clk_p]