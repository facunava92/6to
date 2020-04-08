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
        A           :   in  std_logic_vector(1 downto 0);
        enable      :   in  std_logic;
        D           :   out std_logic_vector(1 downto 0)
    );
end ha1;

architecture arch_ha1 of ha1 is

begin

end arch_ha1;