library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity coloquio1 is
    port ( 
        reset, clk  :   in  std_logic;
        d_out       :   out std_logic_vector(9 downto 0)
    );
end coloquio1;

architecture arch of coloquio1 is
    signal random_reg : std_logic_vector(9 downto 0) := b"00000_00010";
begin

    process(clk, reset)
    begin
        if(reset = '1') then
            random_reg <= b"00000_00010";
        elsif(rising_edge(clk)) then
            random_reg <= random_reg(8 downto 0) & (random_reg(2) xnor random_reg(6));
        end if;
    end process;
    
    d_out <= random_reg;
    
end arch;

architecture arch2 of coloquio1 is
    signal random_next, random_reg : std_logic_vector(9 downto 0) := b"00000_00010";
    signal xnor_reg   : std_logic;
begin

    process(clk, reset)
    begin
        if(reset = '1') then
            random_reg <= b"00000_00010";
        elsif(rising_edge(clk)) then
            random_reg <= random_next;
        end if;
    end process;
    
    xnor_reg <= random_reg(2) xnor random_reg(6);
    random_next <= random_reg(8 downto 0) & xnor_reg;

    
    d_out <= random_reg;
    
end arch2;