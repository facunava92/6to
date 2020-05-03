--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:28:11 05/27/2019
-- Design Name:   
-- Module Name:   D:/Nacho/Facu/TD4/BancoDeContinua/Encoder_tstb.vhd
-- Project Name:  BancoDeContinua
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Cronometro
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Encoder_tstb IS
END Encoder_tstb;
 
ARCHITECTURE behavior OF Encoder_tstb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Cronometro
    PORT(
         clock : IN  std_logic;
         reset : IN  std_logic;
         encA : IN  std_logic;
         encB : IN  std_logic;
         prueba : OUT  std_logic;
         BCD0 : OUT  std_logic_vector(3 downto 0);
         BCD1 : OUT  std_logic_vector(3 downto 0);
         BCD2 : OUT  std_logic_vector(3 downto 0);
         BCD3 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal encA : std_logic := '0';
   signal encB : std_logic := '0';

 	--Outputs
   signal prueba : std_logic;
   signal BCD0 : std_logic_vector(3 downto 0);
   signal BCD1 : std_logic_vector(3 downto 0);
   signal BCD2 : std_logic_vector(3 downto 0);
   signal BCD3 : std_logic;

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Cronometro PORT MAP (
          clock => clock,
          reset => reset,
          encA => encA,
          encB => encB,
          prueba => prueba,
          BCD0 => BCD0,
          BCD1 => BCD1,
          BCD2 => BCD2,
          BCD3 => BCD3
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		reset <= '1';
      wait for 100 us;
		reset <= '0';

		for i in 0 to 1320 loop
			encA <= '0';
			encB <= '0';
			wait for clock_period*10;
			encA <= '1';
			encB <= '0';
			wait for clock_period*10;
			encA <= '1';
			encB <= '1';
			wait for clock_period*10;
			encA <= '0';
			encB <= '1';
			wait for clock_period*10;
		end loop;
		
		for i in 0 to 999 loop
			encA <= '1';
			encB <= '1';
			wait for clock_period*10;
			encA <= '1';
			encB <= '0';
			wait for clock_period*10;
			encA <= '0';
			encB <= '0';
			wait for clock_period*10;
			encA <= '0';
			encB <= '1';
			wait for clock_period*10;
		end loop;

      -- insert stimulus here 

      wait;
   end process;

END;
