library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity coloquio2 is
  generic(
    N : integer := 10);
  port ( 
    reset, clk  :   in  std_logic;
    d_out       :   out std_logic_vector(N-1 downto 0)
    );
end coloquio2;

architecture arch of coloquio2 is
    signal random_reg : std_logic_vector(N-1 downto 0) := b"00000_00010";
begin

    process(clk, reset)
    begin
        if(reset = '1') then
            random_reg <= b"00000_00010";
        elsif(rising_edge(clk)) then
            random_reg <= random_reg(N-2 downto 0) & (random_reg(2) xnor random_reg(6) xnor random_reg((N-7)/2+7));
        end if;
    end process;
    
    d_out <= random_reg;
    
end arch;