library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_coloquio1 is
--Port ( );
end tb_coloquio1;

architecture tb_arch of tb_coloquio1 is
    constant T : time := 10ns;
-- inputs 
    signal reset : std_logic;
    signal clk   : std_logic;
    
-- outputs   
    signal d_out : std_logic_vector (9 downto 0);   
   
begin
--****************************************
-- instantiation
--****************************************
    uut: entity work.coloquio2(arch)
    port map (
        reset => reset,
        clk => clk,
        d_out => d_out
    );
--****************************************
-- clock
--****************************************        
    process
    begin
        clk <= '0';
        wait for T/2;
        clk <= '1';
        wait for T/2;
   end process;         
    
    reset <= '1' , '0' after T/2;
end tb_arch;
