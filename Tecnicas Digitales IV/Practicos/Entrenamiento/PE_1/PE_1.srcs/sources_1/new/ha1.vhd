----------------------------------------------------------------------------------
-- UNIVERSIDAD TECNOLÓGICA NACIONAL - FACULTAD REGIONAL CORDOBA
-- Carrera: INGENIERIA ELECTRÓNICA.
-- Asignatura: TÉCNICAS DIGITALES IV (ELECTIVA).
-- Año: 2020.
-- Integrantes:
--  NAVARRO, Facundo
--  Leg. Nº:63809
--
-- Fecha de Entrega: xx/xx/2020.
-- Hardware utilizado: Basys3
-- VHDL auxiliares utilizados
-- UCF utilizado: basys3.xdc
--
--
--
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ha1 is
    Port (
        a, b        :   in  std_logic;
        enable      :   in  std_logic;
        resultado   :   out std_logic_vector(1 downto 0)
    );
end ha1;

architecture arch_ha1 of ha1 is

begin
    resultado <= "11" when (enable = '0') else
                 "00" when (a='0' and b='0') else
                 "10" when (a='0' and b='1') else
                 "10" when (a='1' and b='0') else                 
                 "01" when (a='1' or b='1');
end arch_ha1;
