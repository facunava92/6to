----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:16:22 05/27/2019 
-- Design Name: 
-- Module Name:    BCD_2bits - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BCD_1bit is
PORT(clk, reset, clk_enable, count_dir: in std_logic;
		carry_out: out std_logic;
		BCD: out std_logic);
end BCD_1bit;

architecture Behavioral of BCD_1bit is
signal count: std_logic;
signal c_out: std_logic;

begin

process(clk, reset)
begin
	if reset = '1' then
		count <= '0';
	elsif clk = '1' and clk'event then
		if clk_enable='1' then
			if count_dir='0' then
				if count = '1' then
					carry_out <= '1';
					count <= '0';
				else
					count <= '1';
					carry_out <= '0';
				end if;
			elsif count_dir='1' then
				if count = '0' then
					carry_out <= '1';
					count <= '1';
				else
					count <= '0';
					carry_out <= '0';
				end if;
			else
				count <= count;
			end if;
		else carry_out <= '0';
		end if;
	end if;
end process; 

BCD <= count;

end Behavioral;


