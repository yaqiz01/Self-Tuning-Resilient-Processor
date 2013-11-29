LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY processor IS
    PORT (	clock	: IN STD_LOGIC;
			reset: IN STD_LOGIC;
			keyboard_in	: IN STD_LOGIC_VECTOR(3 downto 0);
			led_14: out std_logic_vector(14 downto 1);
--			lcd_data	: OUT STD_LOGIC_VECTOR(31 downto 0);
--			debug: out std_logic_vector(31 downto 0);
--			instr_FD: out std_logic_vector(31 downto 0);
--			instr_DX: out std_logic_vector(31 downto 0);
--			instr_XM: out std_logic_vector(31 downto 0);
--			instr_MW: out std_logic_vector(31 downto 0);
			dmem_out_d: out std_logic_vector(31 downto 0);
			alu_a: out std_logic_vector(31 downto 0);
			alu_b: out std_logic_vector(31 downto 0);
			rf_in: out std_logic_vector(31 downto 0)
--			pc_out_d: out std_logic_vector(31 downto 0);
--			pc_set_d: out std_logic_vector(31 downto 0)
--			b4: out std_logic
--			b2: out std_logic;
--			b3: out std_logic;
--			b : out std_logic_vector(8 downto 1);
--			b2_d: out std_logic_vector(31 downto 0)
--			b3: out std_logic_vector(31 downto 0)
			);
END processor;

ARCHITECTURE Structure OF processor IS
	COMPONENT imem IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
		clken		: IN STD_LOGIC ;
		clock		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	END COMPONENT;
	
	COMPONENT dmem IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (11 DOWNTO 0);
		clock		: IN STD_LOGIC ;
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	END COMPONENT;
	
	component multdiv is
	PORT ( data_operandA, data_operandB     : IN STD_LOGIC_VECTOR(15 downto 0);
       ctrl_MULT, ctrl_DIV, clock : IN STD_LOGIC;                
       data_result    : OUT STD_LOGIC_VECTOR(31 downto 0);
       data_exception, data_inputRDY, data_resultRDY  : OUT STD_LOGIC);
	end component;
	
	component alu is
	PORT ( data_operandA, data_operandB   : IN STD_LOGIC_VECTOR(31 downto 0);
       ctrl_ALUopcode : IN STD_LOGIC_VECTOR(4 downto 0); 
       ctrl_shiftamt : IN STD_LOGIC_VECTOR(4 downto 0);
       data_result    : OUT STD_LOGIC_VECTOR(31 downto 0);
       isNotEqual, isLessThan  : OUT STD_LOGIC);
	END component;
	
	component regfile is 
	PORT ( clock, ctrl_writeEnable, ctrl_reset : IN STD_LOGIC;
		ctrl_writeReg, ctrl_readRegA, ctrl_readRegB : IN STD_LOGIC_VECTOR(4 downto 0);
		data_writeReg    : IN STD_LOGIC_VECTOR(31 downto 0);
		data_readRegA, data_readRegB    : OUT STD_LOGIC_VECTOR(31 downto 0));
	END component;
	
	component pc is
	    PORT (	clock, reset, enable, sel_set : IN STD_LOGIC;
			set_value : in STD_LOGIC_VECTOR(31 downto 0);
			pc_value	: Out STD_LOGIC_VECTOR(31 downto 0) );
	end component;
	
	component reg_32 is
	PORT ( input : IN STD_LOGIC_VECTOR(31 downto 0);
	write_enable :IN STD_LOGIC;
	clock: IN STD_LOGIC;
	reset: IN STD_LOGIC;
	output : OUT STD_LOGIC_VECTOR(31 downto 0));
	END component;
	
	component razor_latch is
	PORT ( input : IN STD_LOGIC_VECTOR(31 downto 0);
	write_enable :IN STD_LOGIC;
	clock: IN STD_LOGIC;
	reset: IN STD_LOGIC;
	output : OUT STD_LOGIC_VECTOR(31 downto 0);
	-- shadow_out: OUT STD_LOGIC_VECTOR(31 downto 0);
	error: out std_logic );
	END component;
	
	component sx_17to32 is
	    PORT (	input	: IN STD_LOGIC_VECTOR(16 downto 0);
			output	: OUT STD_LOGIC_VECTOR(31 downto 0));
	end component;
	
	component add_one is
	PORT ( input : IN STD_LOGIC_Vector(31 downto 0);
	carryout : out std_logic;
	sum : OuT STD_LOGIC_Vector(31 downto 0));
	end component;
	
	component three_inputs_adder
	PORT ( data_operandA, data_operandB, data_operandC : IN STD_LOGIC_VECTOR(31 downto 0);
	data_result    : OUT STD_LOGIC_VECTOR(31 downto 0);
	carryout: OUT STD_LOGIC);
	END component;
	
	component addr_eq
    PORT (	addr1, addr2 : in STD_LOGIC_VECTOR(4 downto 0);
			equal: out std_logic);
	END component;
	
	component comparator_32
	PORT ( data_operandA, data_operandB     : IN STD_LOGIC_VECTOR(31 downto 0);
	not_equal: out std_logic;
	less_than: out std_logic);
	end component;
	
	component input_ctrl 
    PORT (	clock: in std_logic;
			keyboard_in	: IN STD_LOGIC_VECTOR(3 downto 0);
			clearup: in std_logic;
			cleardown: in std_logic;
			clearleft: in std_logic;
			clearright: in std_logic;
			goup: out std_logic;
			godown: out std_logic;
			goleft: out std_logic;
			goright: out std_logic
			);
	end component;
	
	component led_ctrl
    PORT (	clock: in std_logic;
			led_id: in std_logic_vector(40 downto 1);
			enable: in std_logic;
			ctrl_on: in std_logic;
			reset: in std_logic;
			pin: out std_logic_vector(14 downto 1)
			);
	end component;
	
	component decoder_6
	    port(bin: In std_logic_vector(5 Downto 0);
         output:   out std_logic_vector(1 to 40)
        );
    end component;
    
   component dflipflop
   port
   ( clock, reset,enable,data : in std_logic;
      output : out std_logic
   );
	end component;
	
	signal pc_out: STD_LOGIC_VECTOR(31 downto 0);
	signal pc_set: STD_LOGIC_VECTOR(31 downto 0);
	signal imem_out: STD_LOGIC_VECTOR(31 downto 0);
	signal regFileAout: STD_LOGIC_VECTOR(31 downto 0);
	signal regFileBout: STD_LOGIC_VECTOR(31 downto 0);
	signal regFile_in: STD_LOGIC_VECTOR(31 downto 0);
	signal regFile_b_addr: STD_LOGIC_VECTOR(4 downto 0);
	signal regFile_a_addr: STD_LOGIC_VECTOR(4 downto 0);
	signal regFile_write_addr: STD_LOGIC_VECTOR(4 downto 0);
	signal sx_out_dx : STD_LOGIC_VECTOR(31 downto 0);
	signal sx_out_fd : STD_LOGIC_VECTOR(31 downto 0);
	signal alu_a_in: STD_LOGIC_VECTOR(31 downto 0);
	signal alu_b_in: STD_LOGIC_VECTOR(31 downto 0);
	signal alu_op: STD_LOGIC_VECTOR(4 downto 0);
	signal alu_out:STD_LOGIC_VECTOR(31 downto 0);
	signal dmem_q: STD_LOGIC_VECTOR(31 downto 0);
	signal pc_add1_out: STD_LOGIC_VECTOR(31 downto 0);
	signal pc_p1_pN: STD_LOGIC_VECTOR(31 downto 0);
	signal RdNeqRs: std_logic;
	signal RdLTRs: std_logic;
	signal dmem_in: STD_LOGIC_VECTOR(31 downto 0);
	signal regFile_rA: STD_LOGIC_VECTOR(31 downto 0);
	signal regFile_rB: STD_LOGIC_VECTOR(31 downto 0);	
	signal goup: std_logic;
	signal goleft: std_logic;
	signal goright: std_logic;
	signal godown: std_logic;
	signal led_id: std_logic_vector (40 downto 1);
	signal branch_reg: std_logic_vector(31 downto 0);
	signal pc_set_buff: std_logic;
	signal pc_set_val_buff: std_logic_vector(31 downto 0);
	signal ctrl_pc_set_delay: std_logic;
			
	signal ir_FD_in: STD_LOGIC_VECTOR(31 downto 0);
	signal ir_FD: STD_LOGIC_VECTOR(31 downto 0);
	signal ir_DX_in: STD_LOGIC_VECTOR(31 downto 0);
	signal ir_DX: STD_LOGIC_VECTOR(31 downto 0);
	signal ir_XM_in: STD_LOGIC_VECTOR(31 downto 0);
	signal ir_XM: STD_LOGIC_VECTOR(31 downto 0);
	signal ir_MW_in: STD_LOGIC_VECTOR(31 downto 0);
	signal ir_MW: STD_LOGIC_VECTOR(31 downto 0);
	signal pc_FD_in: STD_LOGIC_VECTOR(31 downto 0);
	signal pc_FD: STD_LOGIC_VECTOR(31 downto 0);
	signal pc_DX_in: STD_LOGIC_VECTOR(31 downto 0);
	signal pc_DX: STD_LOGIC_VECTOR(31 downto 0);
	signal pc_XM_in: STD_LOGIC_VECTOR(31 downto 0);
	signal pc_XM: STD_LOGIC_VECTOR(31 downto 0);
	signal a_DX_in: STD_LOGIC_VECTOR(31 downto 0);
	signal a_DX: STD_LOGIC_VECTOR(31 downto 0);
	signal b_DX_in: STD_LOGIC_VECTOR(31 downto 0);
	signal b_DX: STD_LOGIC_VECTOR(31 downto 0);
	signal b_XM_in: STD_LOGIC_VECTOR(31 downto 0);
	signal b_XM: STD_LOGIC_VECTOR(31 downto 0);
	signal o_XM_in: STD_LOGIC_VECTOR(31 downto 0);
	signal o_XM: STD_LOGIC_VECTOR(31 downto 0);
	signal o_MW_in: STD_LOGIC_VECTOR(31 downto 0);
	signal o_MW: STD_LOGIC_VECTOR(31 downto 0);
	
	signal ctrl_I_instr: std_logic;
	signal ctrl_alu_a: std_logic;
	signal ctrl_alu_b: std_logic;
	signal ctrl_dmem: std_logic;
	signal ctrl_odlatch: std_logic;
	signal ctrl_regFWE: std_logic;
	signal ctrl_pc_set: std_logic;
	signal ctrl_jr_fd: std_logic;
	signal ctrl_j_fd: std_logic;
	signal ctrl_jal_fd: std_logic;
	signal ctrl_sw_fd: std_logic;
	signal ctrl_bne_fd: std_logic;
	signal ctrl_blt_fd: std_logic;
	signal ctrl_R_fd: std_logic;
	signal ctrl_addi_fd: std_logic;
	signal ctrl_lw_fd: std_logic;
	signal ctrl_iu_fd: std_logic;
	signal ctrl_id_fd: std_logic;
	signal ctrl_il_fd: std_logic;
	signal ctrl_ir_fd: std_logic;
	signal ctrl_out_fd: std_logic;
	signal ctrl_R_dx: std_logic;
	signal ctrl_addi_dx: std_logic;
	signal ctrl_lw_dx: std_logic;
	signal ctrl_sw_dx: std_logic;
	signal ctrl_lw_mw: std_logic;
	signal ctrl_R_mw: std_logic;
	signal ctrl_addi_mw: std_logic;
	signal ctrl_R_xm: std_logic;
	signal ctrl_addi_xm: std_logic;
		
	signal dhazd_rsDX_eq_rdXM: std_logic;
	signal dhazd_rtDX_eq_rdXM: std_logic;
	signal dhazd_rdDX_eq_rdXM: std_logic;
	
	signal dhazd_rsFD_eq_rdMW: std_logic;
	signal dhazd_rtFD_eq_rdMW: std_logic;
	signal dhazd_rdFD_eq_rdMW: std_logic;
	
	signal dhazd_rsFD_eq_rdDX: std_logic;
	signal dhazd_rdFD_eq_rdDX: std_logic;
	signal dhazd_rtFD_eq_rdDX: std_logic;
	
	signal dhazd_rsFD_eq_rdXM: std_logic;
	signal dhazd_rdFD_eq_rdXM: std_logic;
		
	signal dhazd_rsDX_eq_rdMW: std_logic;
	signal dhazd_rtDX_eq_rdMW: std_logic;
	signal dhazd_rdDX_eq_rdMW: std_logic;
	signal stall: std_logic;
	
	-- Recovery Signals for Error Detection Scheme
	signal rec_ir_FD: std_logic;
	signal rec_ir_DX: std_logic;
	signal rec_ir_XM: std_logic;

	signal rec_pc_FD: std_logic;
	signal rec_pc_DX: std_logic;
	signal rec_pc_XM: std_logic;
	signal rec_a_DX: std_logic;
	signal rec_b_DX: std_logic;
	signal rec_b_XM: std_logic;
	signal rec_o_XM: std_logic;
	signal rec_o_MW: std_logic;
	
	signal latch_error: std_logic;
		
BEGIN
	
	-- Your processor here
	--latches--
	IRlatch_FD: razor_latch port map (ir_FD_in, not DX_stall or not XM_stall or not MW_stall, clock, reset, ir_FD, rec_ir_FD); -- CREATE ir_FD_in
	IRlatch_DX: razor_latch port map (ir_DX_in, '1', clock, reset, ir_DX, rec_ir_DX);
	IRlatch_XM: razor_latch port map (ir_XM_in, '1', clock, reset, ir_XM, rec_ir_XM);
	IRlatch_MW: razor_latch port map (ir_MW_in, '1', clock, reset, ir_MW, rec_ir_MW);
	PClatch_FD: razor_latch port map (pc_FD_in, '1', clock, reset, pc_FD, rec_pc_FD);
	PClatch_DX: razor_latch port map (pc_DX_in, '1', clock, reset, pc_DX, rec_pc_DX);
	PClatch_XM: razor_latch port map (pc_XM_in, '1', clock, reset, pc_XM, rec_pc_XM);
	Alatch_DX: razor_latch port map (a_DX_in, '1', clock, reset, a_DX, rec_a_DX);
	Blatch_DX: razor_latch port map (b_DX_in, '1', clock, reset, b_DX, rec_b_DX);
	Blatch_XM: razor_latch port map (b_XM_in, '1', clock, reset, b_XM, rec_b_XM);
	Olatch_XM: razor_latch port map (o_XM_in, '1', clock, reset, o_XM, rec_o_XM);
	Olatch_MW: razor_latch port map (o_MW_in, '1', clock, reset, o_MW, rec_o_MW);
	Dlatch_MW: razor_latch port map (dmem_q, '1', clock, reset, d_MW, 
	PC_set_val: reg_32 port map (pc_set_val_buff, '1', not clock, reset, pc_set);
	branch_latch: reg_32 port map (pc_add1_out, ctrl_jal_fd or
									(ctrl_iu_fd and goup) or
									(ctrl_id_fd and godown) or
									(ctrl_il_fd and goleft) or
									(ctrl_il_fd and goright), clock, reset, branch_reg);
	-----------
	
	pc_counter: pc port map (clock, reset , not stall, ctrl_pc_set, pc_set, pc_out);
	pc_set_val_buff(31 downto 27) <= pc_FD( 31 downto 27) when (ctrl_j_fd = '1' or ctrl_jal_fd = '1' 
														or (ctrl_iu_fd = '1' and goup = '1')
														or (ctrl_id_fd = '1' and godown = '1')
														or (ctrl_il_fd = '1' and goleft = '1')
														or (ctrl_ir_fd = '1' and goright = '1')
														) -- pc = N jal, j, iu, id, il, ir
							else branch_reg(31 downto 27) when ctrl_jr_fd = '1' -- jr PC = $rd
							else pc_p1_pN(31 downto 27) when ((ctrl_bne_fd = '1' and RdNeqRs = '1') or (ctrl_blt_fd = '1' and RdLTRs = '1'))--pc + 1 + n;
							else "00000";
	pc_set_val_buff(26 downto 0) <= imem_out (26 downto 0) when (ctrl_j_fd = '1' or ctrl_jal_fd = '1' 
														or (ctrl_iu_fd = '1' and goup = '1')
														or (ctrl_id_fd = '1' and godown = '1')
														or (ctrl_il_fd = '1' and goleft = '1')
														or (ctrl_ir_fd = '1' and goright = '1')
														) -- pc = N jal, j, iu, id, il, ir
							else branch_reg(26 downto 0) when ctrl_jr_fd = '1' -- pc = $rd jr
							else pc_p1_pN(26 downto 0) when ((ctrl_bne_fd = '1' and RdNeqRs = '1') or (ctrl_blt_fd = '1' and RdLTRs = '1'))--pc + 1 + n;
							else "000000000000000000000000000";
	set_at_fall : dflipflop port map (not clock, reset,'1',pc_set_buff, ctrl_pc_set);
	delay_one_cycle : dflipflop port map (clock, reset,'1',pc_set_buff, ctrl_pc_set_delay);
	
	pc_set_buff <= (ctrl_bne_fd and RdNeqRs) or (ctrl_blt_fd and RdLTRs) or ctrl_jr_fd or ctrl_j_fd or ctrl_jal_fd
					or (ctrl_iu_fd and goup )
					or (ctrl_id_fd and godown)
					or (ctrl_il_fd and goleft)
					or (ctrl_ir_fd and goright);
	pc_add_1_add_N: three_inputs_adder port map (sx_out_fd, pc_FD, "00000000000000000000000000000001",pc_p1_pN,open);
	
	--- IO----
	input_control: input_ctrl port map(clock, keyboard_in, ctrl_iu_fd or reset, ctrl_id_fd or reset, ctrl_il_fd or reset, ctrl_ir_fd or reset, goup, godown, goleft, goright);
	decode : decoder_6 port map (regFile_rA(5 downto 0), led_id);
	output_control: led_ctrl port map (clock, led_id, ctrl_out_fd, imem_out(0),reset,led_14);
	----------
	
	compare: comparator_32 port map (regFile_rB, regFile_rA, RdNeqRs, RdLTRs);
	regFile_rB <= alu_out when (ctrl_R_dx = '1' or ctrl_addi_dx = '1') and dhazd_rdFD_eq_rdDX = '1'
			else o_XM  when (ctrl_R_xm = '1' or ctrl_addi_xm = '1') and dhazd_rdFD_eq_rdXM = '1'
			else regFile_in when (ctrl_R_mw = '1' or ctrl_addi_mw = '1' or ctrl_lw_mw = '1') and 
									((dhazd_rtFD_eq_rdMW= '1' and ctrl_R_fd = '1')
									or (dhazd_rdFD_eq_rdMW = '1' and (ctrl_R_fd = '1' or ctrl_sw_fd = '1')))
			else regFileBout; -- compare switch rs and rd
	regFile_rA <= alu_out when (ctrl_R_dx = '1' or ctrl_addi_dx = '1') and dhazd_rsFD_eq_rdDX = '1'
			else o_XM  when (ctrl_R_xm = '1' or ctrl_addi_xm = '1') and dhazd_rsFD_eq_rdXM = '1'
			else regFile_in when (ctrl_R_mw = '1' or ctrl_addi_mw = '1' or ctrl_lw_mw = '1') and dhazd_rsFD_eq_rdMW = '1'
			else regFileAout;

	instr_memory: imem PORT MAP(pc_out(11 downto 0),not stall, not clock, imem_out); -- not clock because need to read at falling edge!!
	data_memory: dmem port map (o_XM(11 downto 0), clock, dmem_in, ctrl_dmem, dmem_q);
	dmem_in<= b_XM; 
													
	alu_a_in <= o_MW when dhazd_rsDX_eq_rdMW = '1' and
						(ctrl_R_dx = '1' or ctrl_addi_dx = '1' or ctrl_lw_dx = '1' or ctrl_sw_dx = '1') and
						(ctrl_R_mw = '1' or ctrl_addi_mw = '1')
			else dmem_q when (ctrl_lw_MW = '1' and dhazd_rsDX_eq_rdMW = '1'
							and (ctrl_R_dx = '1' or ctrl_addi_dx = '1' or ctrl_lw_dx = '1' or ctrl_sw_dx = '1'))
			else o_XM when (dhazd_rsDX_eq_rdXM = '1'
						and (ctrl_R_xm = '1' or ctrl_addi_xm = '1')
						and (ctrl_R_dx = '1' or ctrl_addi_dx = '1' or ctrl_lw_dx = '1' or ctrl_sw_dx = '1'))
			else a_DX ;
	-- when a_DX;
	alu_b_in <= o_MW when ((dhazd_rtDX_eq_rdMW = '1' and ctrl_R_dx = '1')  -- read rt
						or (dhazd_rdDX_eq_rdMW = '1' and (ctrl_R_dx = '1' or ctrl_sw_dx = '1'))) --read rd
					 and (ctrl_R_mw = '1' or ctrl_addi_mw = '1') -- write RF
			else dmem_q when ctrl_lw_MW = '1' -- write RF
						and ((dhazd_rtDX_eq_rdMW = '1' and ctrl_R_dx = '1') -- read rt
						or(dhazd_rdDX_eq_rdMW = '1' and (ctrl_R_dx = '1' or ctrl_sw_dx = '1'))) --read rd
			else o_XM when (ctrl_R_xm = '1' or ctrl_addi_xm = '1')-- write regFile
							and ((dhazd_rtDX_eq_rdXM = '1' and ctrl_R_dx = '1') --read rt
								or (dhazd_rdDX_eq_rdXM = '1' and (ctrl_R_dx = '1' or ctrl_sw_dx = '1')))-- rd
			else sx_out_dx when ctrl_I_instr = '1'
			else b_DX;

	ctrl_I_instr <= ctrl_addi_dx -- andi 00001
				or ctrl_lw_dx -- lw 00010
				or ctrl_sw_dx; --sw 00011	
	alu_op <= ir_DX(6 downto 2) when ir_DX(31 downto 27) = "00000" else "00000";
	alu_compo: alu port map (alu_a_in, alu_b_in, alu_op , ir_DX(11 downto 7), alu_out, open, open);
	
	register_file: regfile port map (clock, ctrl_regFWE, reset,regFile_write_addr ,regFile_a_addr, regFile_b_addr,regFile_in ,regFileAout,regFileBout);
	regFile_b_addr <= imem_out(26 downto 22) when (ctrl_sw_fd = '1' or ctrl_bne_fd = '1' or ctrl_blt_fd = '1' ) -- rs when sw, bne, blt, jr
					else imem_out(16 downto 12); --rt for R, lw, jal and addi don't care
	regFile_a_addr <= imem_out(21 downto 17);
	
	regFile_in <= dmem_q when ctrl_lw_MW = '1' 
		else o_MW;
	regFile_write_addr <= ir_MW(26 downto 22);
	ctrl_regFWE <= ctrl_R_mw or ctrl_addi_mw or ctrl_lw_mw;

	pc_add_one: add_one port map (pc_FD, open, pc_add1_out);
	
	sign_extension_dx: sx_17to32 port map (ir_DX(16 downto 0), sx_out_dx);
	sign_extension_fd: sx_17to32 port map (imem_out(16 downto 0), sx_out_fd);
	
	rsDX_eq_rdXM: addr_eq port map (ir_DX(21 downto 17), ir_XM(26 downto 22), dhazd_rsDX_eq_rdXM);
	rtDX_eq_rdXM: addr_eq port map (ir_DX(16 downto 12), ir_XM(26 downto 22), dhazd_rtDX_eq_rdXM);
	rdDX_eq_rdXM: addr_eq port map (ir_DX(26 downto 22), ir_XM(26 downto 22), dhazd_rdDX_eq_rdXM);
	
	rsDX_eq_rdMW: addr_eq port map (ir_DX(21 downto 17), ir_MW(26 downto 22), dhazd_rsDX_eq_rdMW);
	rtDX_eq_rdMW: addr_eq port map (ir_DX(16 downto 12), ir_MW(26 downto 22), dhazd_rtDX_eq_rdMW);
	rdDX_eq_rdMW: addr_eq port map (ir_DX(26 downto 22), ir_MW(26 downto 22), dhazd_rdDX_eq_rdMW);
	
	rsFD_eq_rdDX: addr_eq port map (imem_out(21 downto 17), ir_DX(26 downto 22), dhazd_rsFD_eq_rdDX);
	rdFD_eq_rdDX: addr_eq port map (imem_out(26 downto 22), ir_DX(26 downto 22), dhazd_rdFD_eq_rdDX);
	rtFD_eq_rdDX: addr_eq port map (imem_out(16 downto 12), ir_DX(26 downto 22), dhazd_rtFD_eq_rdDX);
	
	rsFD_eq_rdXM: addr_eq port map (imem_out(21 downto 17), ir_XM(26 downto 22), dhazd_rsFD_eq_rdXM);
	rdFD_eq_rdXM: addr_eq port map (imem_out(26 downto 22), ir_XM(26 downto 22), dhazd_rdFD_eq_rdXM);
	
	rsFD_eq_rdMW: addr_eq port map (imem_out(21 downto 17), ir_MW(26 downto 22), dhazd_rsFD_eq_rdMW);
	rtFD_eq_rdMW: addr_eq port map (imem_out(16 downto 12), ir_MW(26 downto 22), dhazd_rtFD_eq_rdMW);
	rdFD_eq_rdMW: addr_eq port map (imem_out(26 downto 22), ir_MW(26 downto 22), dhazd_rdFD_eq_rdMW);
	
	ctrl_dmem <= not ir_XM(31) and not ir_XM(30) and not ir_XM(29) and ir_XM(28) and ir_XM(27); --00011 sw
	-- od: not for jr since jr don't write back
									
	ctrl_bne_fd <= not imem_out(31) and not imem_out(30) and imem_out(29) and not imem_out(28) and not imem_out(27); -- bne 00100
	ctrl_blt_fd <=  not imem_out(31) and not imem_out(30) and imem_out(29) and not imem_out(28) and imem_out(27);-- blt 00101
	ctrl_jr_fd <= 	not imem_out(31) and imem_out(30) and not imem_out(29) and not imem_out(28) and not imem_out(27); --jr 01000		
	ctrl_j_fd <= not imem_out(31) and not imem_out(30) and imem_out(29) and imem_out(28) and not imem_out(27);-- j 00110
	ctrl_sw_fd <= not imem_out(31) and not imem_out(30) and not imem_out(29) and imem_out(28) and imem_out(27); -- sw 00011
	ctrl_jal_fd <= not imem_out(31) and not imem_out(30) and imem_out(29) and imem_out(28) and imem_out(27);-- jal 00111
	ctrl_R_fd <= not imem_out(31) and not imem_out(30) and not imem_out(29) and not imem_out(28) and not imem_out(27); -- R00000
	ctrl_addi_fd <= not imem_out(31) and not imem_out(30) and not imem_out(29) and not imem_out(28) and imem_out(27);-- addi 00001
	ctrl_lw_fd <= not imem_out(31) and not imem_out(30) and not imem_out(29) and imem_out(28) and not imem_out(27); -- lw 00010
	ctrl_iu_fd <= not imem_out(31) and imem_out(30) and not imem_out(29) and not imem_out(28) and imem_out(27); -- 01001
	ctrl_id_fd <= not imem_out(31) and imem_out(30) and not imem_out(29) and imem_out(28) and not imem_out(27); -- 01010
	ctrl_il_fd <= not imem_out(31) and imem_out(30) and not imem_out(29) and imem_out(28) and imem_out(27); -- 01011
	ctrl_ir_fd <= not imem_out(31) and imem_out(30) and imem_out(29) and not imem_out(28) and not imem_out(27); --01100
	ctrl_out_fd <= not imem_out(31) and imem_out(30) and imem_out(29) and not imem_out(28) and imem_out(27); --01101
	
	ctrl_addi_xm <= not ir_XM(31) and not ir_XM(30) and not ir_XM(29) and not ir_XM(28) and ir_XM(27);-- addi 00001
	ctrl_R_xm <=  not ir_XM(31) and not ir_XM(30) and not ir_XM(29) and not ir_XM(28) and not ir_XM(27);-- R 00000
	
	ctrl_R_dx <= not ir_DX(31) and not ir_DX(30) and not ir_DX(29) and not ir_DX(28)and not ir_DX(27); -- R00000
	ctrl_addi_dx <= not ir_DX(31) and not ir_DX(30) and not ir_DX(29) and not ir_DX(28)and ir_DX(27);--addi 00001
	ctrl_lw_dx <= not ir_DX(31) and not ir_DX(30) and not ir_DX(29) and ir_DX(28) and not ir_DX(27);--lw 00010
	ctrl_sw_dx <= not ir_DX(31) and not ir_DX(30) and not ir_DX(29) and ir_DX(28)and ir_DX(27); --sw 00011
	
	ctrl_lw_mw <= not ir_MW(31) and not ir_MW(30) and not ir_MW(29) and ir_MW(28) and not ir_MW(27);-- lw 00010
	ctrl_R_mw <= not ir_MW(31) and not ir_MW(30) and not ir_MW(29) and not ir_MW(28) and not ir_MW(27); -- R
	ctrl_addi_mw <= not ir_MW(31) and not ir_MW(30) and not ir_MW(29) and not ir_MW(28) and ir_MW(27); -- addi
	
	ir_FD_in <= "00000000000000000000000000000000" when FD_stall else imem_out;
	ir_DX_in <= "00000000000000000000000000000000" when DX_stall else ir_FD;
	ir_XM_in <= "00000000000000000000000000000000" when (rec_ir_XM ='1' or rec_pc_XM ='1') and not(clock) else ir_DX;
	ir_MW_in <= "00000000000000000000000000000000" when rec_ir_MW ='1' and not(clock) else ir_XM;
	pc_FD_in <= "00000000000000000000000000000000" when FD_stall else pc_out;
	pc_DX_in <= "00000000000000000000000000000000" when DX_stall else pc_FD;
	pc_XM_in <= "00000000000000000000000000000000" when XM_stall else pc_DX;
	a_DX_in <= "00000000000000000000000000000000" when DX_stall else regFile_rA;
	b_DX_in <= "00000000000000000000000000000000" when DX_stall else regFile_rB;
	stall <= load_stall_data_hzd or latch_error;
	latch_error <= rec_ir_FD or rec_ir_DX or rec_ir_O or rec_ir_XM or rec_ir_MW or rec_pr_FD or rec_pc_DX or rec_pc_XM or rec_pc_XM or rec_b_DX or rec_b_XM or rec_o_XM or rec_o_MW when clock = '0' else '0';			
	load_stall_data_hzd <= (ctrl_lw_dx)-- lw 00010
			and 
			((dhazd_rsFD_eq_rdDX and (ctrl_R_fd or ctrl_addi_fd or ctrl_lw_fd or ctrl_sw_fd or ctrl_bne_fd or ctrl_blt_fd or ctrl_out_fd))
			or (dhazd_rtFD_eq_rdDX and (ctrl_R_fd))
			or (dhazd_rdFD_eq_rdDX and (ctrl_sw_fd or ctrl_bne_fd or ctrl_blt_fd))); -- no check for instr read rd or
	
	FD_stall <= ((rec_ir_FD ='1' or rec_pc_FD ='1') and not(clock));
	DX_stall <= ((rec_ir_DX ='1' or rec_pc_DX ='1' or rec_a_DX ='1' or rec_b_DX ='1') and not(clock)) or load_stall_data_hzd;
	XM_stall <= ((rec_ir_XM ='1' or rec_pc_XM ='1' or rec_o_XM ='1' or rec_b_XM ='1') and not(clock));
	MW_stall <= ((rec_ir_MW ='1' or rec_o_MW ='1' or rec_d_MW='1') and not(clock));
	
--	lcd_data <= imem_out;
--	debug <= regFile_rA;
--	instr_DX <= ir_DX;
--	instr_FD <= imem_out;
--	instr_XM <= ir_XM;
--	instr_MW <= ir_MW;
	dmem_out_d<= dmem_q;
	alu_a <= alu_a_in;
	alu_b <= alu_b_in;
	rf_in<= regFile_in;
--	pc_out_d <= pc_out;
--	pc_set_d <=  pc_set;
--	b2_d <= branch_reg;
--	b3 <=  ctrl_pc_set_delay;
--	b4 <=  ctrl_pc_set;
---	b(1) <= (ctrl_bne_fd and RdNeqRs);
--	b(2) <= (ctrl_blt_fd and RdLTRs);
--	b(3) <= ctrl_jr_fd or ctrl_j_fd;
--	b(4) <= ctrl_jal_fd;
--	b(5) <= (ctrl_iu_fd and goup );
--	b(6) <= (ctrl_id_fd and godown);
--	b(7) <= (ctrl_il_fd and goleft);
--	b(8) <= (ctrl_ir_fd and goright);
END Structure;