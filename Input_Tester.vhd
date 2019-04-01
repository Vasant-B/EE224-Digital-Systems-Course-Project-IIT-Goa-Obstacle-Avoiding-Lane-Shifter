library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;



entity Input_Tester is
	port (CLK : in std_logic;
			I : in  std_logic_vector(3 downto 0); -- output from the LDR Circuit as the Input to Helium Board
			O_Disp: out std_logic_vector(3 downto 0)
			);
	
end Input_Tester;

architecture FUNTIONALITY of Input_Tester is
	

begin
	Process (I, CLK)
	begin
	if CLK'event and CLK = '1' then
	O_Disp <= I;
	end if;
	end Process;	
end FUNTIONALITY;