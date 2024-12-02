# Clock Constraints
# Primary system and reference clocks with their respective periods
create_clock -period 10.000 [get_ports sysclk_p]
create_clock -period 10.000 [get_ports {pcie_ref_clk_p[0]}]
create_clock -period 6.400 [get_ports {hs_ref_clk_p[0]}]
create_clock -period 5.000 [get_ports {ddr_clk_in_p[0]}]

# GTM Transceiver Configuration
# High-speed GTM quad placements for optimal signal integrity
set_property LOC GTM_QUAD_X0Y19 [get_cells GTM_Transceivers/design_1_i/gt_quad_base/inst/quad_inst]
set_property LOC GTM_QUAD_X0Y20 [get_cells GTM_Transceivers/design_1_i/gt_quad_base_1/inst/quad_inst]
set_property LOC GTM_QUAD_X0Y21 [get_cells GTM_Transceivers/design_1_i/gt_quad_base_2/inst/quad_inst]
set_property LOC GTM_QUAD_X0Y22 [get_cells GTM_Transceivers/design_1_i/gt_quad_base_3/inst/quad_inst]

# High-speed reference clock pin assignment
set_property PACKAGE_PIN K26 [get_ports {hs_ref_clk_p[0]}]

# PCIe Interface Configuration
# Setting up PCIe quad location for optimal routing
set_property LOC GTYP_QUAD_X1Y0 [get_cells PCIe_IP/design_2_i/pcie_versal_0_support/gt_quad_0/inst/quad_inst]
set_property PACKAGE_PIN AT48 [get_ports {pcie_ref_clk_p[0]}]

# Differential Signal Assignments (703 Interface)
# Critical timing signals with LVDS15 standard
set_property PACKAGE_PIN BT9 [get_ports sysclk_p]
set_property PACKAGE_PIN BR1 [get_ports diff_a_p]
set_property PACKAGE_PIN BW7 [get_ports diff_b_p]
set_property PACKAGE_PIN BW8 [get_ports diff_c_p]
set_property PACKAGE_PIN BU12 [get_ports diff_d_p]
set_property PACKAGE_PIN BU10 [get_ports diff_e_p]
set_property PACKAGE_PIN BU11 [get_ports diff_f_p]
set_property PACKAGE_PIN BU13 [get_ports diff_g_p]
set_property PACKAGE_PIN BW12 [get_ports diff_h_p]
set_property PACKAGE_PIN BR13 [get_ports diff_i_p]
set_property PACKAGE_PIN BR15 [get_ports diff_j_p]

# Single-ended Signal Assignments (706 Interface)
# Control and status signals using LVCMOS15
set_property PACKAGE_PIN CB25 [get_ports sys_reset]
set_property PACKAGE_PIN CB24 [get_ports pcie_reset]
set_property PACKAGE_PIN CA22 [get_ports port_a]
set_property PACKAGE_PIN CA23 [get_ports port_b]
set_property PACKAGE_PIN BN24 [get_ports port_c]
set_property PACKAGE_PIN BR21 [get_ports port_d]
set_property PACKAGE_PIN BR25 [get_ports port_e]
set_property PACKAGE_PIN BR22 [get_ports port_f]
set_property PACKAGE_PIN BR23 [get_ports port_g]
set_property PACKAGE_PIN BU25 [get_ports port_h]
set_property PACKAGE_PIN BL25 [get_ports port_i]
set_property PACKAGE_PIN BK22 [get_ports port_j]

# DDR Memory Controller Interface
# Memory interface signals with appropriate standards for DDR4/5
set_property PACKAGE_PIN BH9 [get_ports {ddr_clk_in_p[0]}]
set_property PACKAGE_PIN BH8 [get_ports {ddr_clk_in_n[0]}]
set_property PACKAGE_PIN BJ9 [get_ports {ddr_reset_n[0]}]

# Setting I/O Standards
# Configure electrical characteristics for different interfaces
set_property IOSTANDARD LVDS15 [get_ports sysclk_p]
set_property IOSTANDARD LVCMOS15 [get_ports sys_reset]
set_property IOSTANDARD LVCMOS15 [get_ports pcie_reset]
set_property IOSTANDARD LVDS15 [get_ports diff_a_p]
set_property IOSTANDARD LVDS15 [get_ports diff_b_p]
set_property IOSTANDARD LVDS15 [get_ports diff_c_p]
set_property IOSTANDARD LVDS15 [get_ports diff_d_p]
set_property IOSTANDARD LVDS15 [get_ports diff_e_p]
set_property IOSTANDARD LVDS15 [get_ports diff_f_p]
set_property IOSTANDARD LVDS15 [get_ports diff_g_p]
set_property IOSTANDARD LVDS15 [get_ports diff_h_p]
set_property IOSTANDARD LVDS15 [get_ports diff_i_p]
set_property IOSTANDARD LVDS15 [get_ports diff_j_p]
set_property IOSTANDARD LVCMOS15 [get_ports port_*]

# DDR Interface Standards
set_property IOSTANDARD LVDS15 [get_ports {ddr_clk_in_p[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports {ddr_reset_n[0]}]
set_property IOSTANDARD DIFF_POD12 [get_ports {ddr_dqs_p[*]}]
set_property IOSTANDARD POD12 [get_ports {ddr_dq[*]}]
set_property IOSTANDARD SSTL12 [get_ports {ddr_addr[*]}]
