----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:02:20 05/13/2019 
-- Design Name: 
-- Module Name:    Contador - Behavioral 
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

entity Encoder is
PORT(
clock, reset, encA, encB: in std_logic;
vel_up, vel_down: in std_logic;
PWM: out std_logic;
LED: out std_logic_vector (6 downto 0);
transistores: out std_logic_vector (3 downto 0));

end Encoder;

architecture Behavioral of Encoder is


--Señales generales
signal clock_enable: STD_LOGIC;
signal counter : integer range 0 to 35 := 0;
signal clock_div: STD_LOGIC_VECTOR(1 downto 0);


--Señales para contador del encoder
signal dir: std_logic;
signal carry: std_logic_vector (3 downto 0);
signal BCD, BCD0, BCD1, BCD2: std_logic_vector(3 downto 0);
signal BCD3: std_logic_vector(3 downto 0) := "0000";

--Señales control de velocidad

signal ref: std_logic_vector (15 downto 0);
signal BCD_concatenados: std_logic_vector (15 downto 0);



	COMPONENT BCD_display
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		clk_enable : IN std_logic;
		count_dir : IN std_logic;          
		carry_out : OUT std_logic;
		BCD : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
	COMPONENT BCD_1bit is
	PORT(
		clk, reset, clk_enable, count_dir: in std_logic;
		carry_out: out std_logic;
		BCD: out std_logic);
	end COMPONENT;


--Estados
type state_type is (st1_pulso00, st2_pulso01, st3_pulso10, st4_pulso11); 
signal state, next_state, prev_state : state_type;
begin



--Divisor de Frecuencia para barrido de displays
	process (reset, clock) begin
        if (reset = '1') then
            clock_div <= "00";
            counter <= 0;
        elsif rising_edge(clock) then
            if (counter = 70) then
                clock_div <= clock_div + 1;
                counter <= 0;
            else
					 clock_div <= clock_div;
                counter <= counter + 5;
            end if;
        end if;
    end process;
--

--Maquina de Estado
   SYNC_PROC: process (clock)
   begin
      if (clock'event and clock = '1') then
         if (reset = '1') then
            state <= st1_pulso00;
				prev_state <= st1_pulso00;
         else
				prev_state <= state;
            state <= next_state;
         end if;        
      end if;
   end process;
	
	OUTPUT_DECODE: process (state, prev_state)
   begin
      if state /= prev_state then
         clock_enable <= '1';
      else
         clock_enable <= '0';
      end if;
   end process;

   NEXT_STATE_DECODE: process (state, encA, encB)
   begin
      next_state <= state;
      case (state) is
         when st1_pulso00 => -- Estado AB = 00
            if encA = '1' then
               next_state <= st2_pulso01;
					dir <= '0';
            end if;
				if encB = '1' then
					next_state <= st4_pulso11;
					dir <= '1';
				end if;
         when st2_pulso01 => -- Estado AB = 10
            if encB = '1' then
               next_state <= st3_pulso10;
					dir <= '0';
				end if;
				if encA = '0' then
					next_state <= st1_pulso00;
					dir <= '1';
				end if;
         when st3_pulso10 => -- Estado AB = 11
            if encA = '0' then
					next_state <= st4_pulso11;
					dir <= '0';
				end if;
				if encB = '0' then
					next_state <= st2_pulso01;
					dir <= '1';
				end if;
			when st4_pulso11 => -- Estado AB = 01
				if encB = '0' then
					next_state <= st1_pulso00;
					dir <= '0';
				end if;
				if encA = '1' then
					next_state <= st3_pulso10;
					dir <= '1';
				end if;
			when others =>
            next_state <= st1_pulso00;
      end case;      
   end process;
	
--Contador BCD
	Primero: BCD_display PORT MAP(
		clk => clock,
		reset => reset,
		clk_enable => clock_enable,
		count_dir => dir,
		carry_out => carry(0), 
		BCD => BCD0
	);
	
	Segundo: BCD_display PORT MAP(
		clk => clock,
		reset => reset,
		clk_enable => carry(0),
		count_dir => dir,
		carry_out => carry(1),
		BCD => BCD1
	);
	
	Tercero: BCD_display PORT MAP(
		clk => clock,
		reset => reset,
		clk_enable => carry(1),
		count_dir => dir,
		carry_out => carry(2),
		BCD => BCD2
	);
	
	Cuarto: BCD_1bit PORT MAP(
		clk => clock,
		reset => reset,
		clk_enable => carry(2),
		count_dir => dir,
		BCD => BCD3(0)
	);


-- Decodificador para displays
	with BCD SELect
   LED<= "1111001" when "0001",   --1
         "0100100" when "0010",   --2
         "0110000" when "0011",   --3
         "0011001" when "0100",   --4
         "0010010" when "0101",   --5
         "0000010" when "0110",   --6
         "1111000" when "0111",   --7
         "0000000" when "1000",   --8
         "0010000" when "1001",   --9
         "1000000" when others;   --0
			

			 
-- Barrido de Displays
	
	BARRIDO: process(clock, clock_div)
	begin
		if (clock'event and clock = '1') then
			case clock_div is
				when "00" => BCD <= BCD0;
								 transistores <= "0001";
				when "01" => BCD <= BCD1;
								 transistores <= "0010";
				when "10" => BCD <= BCD2;
								 transistores <= "0100";
				when "11" => BCD <= BCD3;
								 transistores <= "1000";
				when others => BCD <= BCD0;
									transistores <= "0000";
			end case; 
		end if;
	end process;
 
-- PWM
   MODIFICAR_REF: process (clock, reset) 
	begin
		if reset = '1' then
			ref <= "0001000000000000";
		elsif clock='1' and clock'event then
			if vel_up = '1' then
				ref <= ref + 250;
			elsif vel_down = '1' then
				ref <= ref - 250;
			else
				ref <= ref;
			end if;
		end if;
	end process;

BCD_concatenados <= BCD3&BCD2&BCD1&BCD0;
   GENERAR_PWM: process (clock) 
	begin
		if clock='1' and clock'event then
			if BCD_concatenados > ref then
				PWM <= '1';
			else
				PWM <= '0';
			end if;
		end if;
	end process;


end Behavioral;

