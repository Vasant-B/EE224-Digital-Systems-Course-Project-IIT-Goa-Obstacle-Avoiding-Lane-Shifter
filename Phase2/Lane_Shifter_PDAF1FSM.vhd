library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Lane_Shifter_PDAF1FSM is
	port (CLK : in std_logic;
			I : in  std_logic_vector(3 downto 0); -- output from the LDR Circuit as the Input to Helium Board
			O_ard : out std_logic_vector(1 downto 0); -- Binary of the Next_Position
			BRAKE : inout std_logic;					  -- output from the Helium Board that indicates the Brake
			PARK : in std_logic := '0';				--select between PARK mode and DRIVE Mode    PARK mode when '1', DRIVE mode when '0'
			LEFTSHIFT, RIGHTSHIFT : out std_logic := '0';
			parkout : out std_logic := '0'
			);
end Lane_Shifter_PDAF1FSM;


architecture FUNTIONALITY of Lane_Shifter_PDAF1FSM is
	
	
	type STATE_TYPE is (S0, S1, S2, S3);
	signal Q, QPLUS  : STATE_TYPE := S0;
	signal Position, Next_Position : integer range 0 to 3 := 0 ;
	
	
begin
	
	process (Q, I)
	begin
	case Q is
	
	when S0 =>
		Position <= 0;
		if (I(0)='1') then
			QPLUS <= S0;
		elsif (I(0)='0') and (I(1)='1') then
			QPLUS <= S1;
		elsif (I(0)='0') and (I(1)='0') and (I(2)='1')then
			QPLUS <= S2;
		elsif (I(0)='0') and (I(1)='0') and (I(2)='0') and (I(3)='1')then
			QPLUS <= S3;
		end if;
	
	when S1 =>
		Position <= 1;
		if (I(1)='1') then
			QPLUS <= S1;
		elsif (I(1)='0') and (I(0)='1') then
			QPLUS <= S0;
		elsif (I(1)='0') and (I(0)='0') and (I(2)='1')then
			QPLUS <= S2;
		elsif (I(1)='0') and (I(0)='0') and (I(2)='0') and (I(3)='1')then
			QPLUS <= S3;
		end if;
	
	
	when S2 =>
		Position <= 2;
		if (I(2)='1') then
			QPLUS <= S2;
		elsif (I(2)='0') and (I(1)='1') then
			QPLUS <= S1;
		elsif (I(2)='0') and (I(1)='0') and (I(3)='1')then
			QPLUS <= S3;
		elsif (I(2)='0') and (I(1)='0') and (I(3)='0') and (I(0)='1')then
			QPLUS <= S0;
		end if;
	
	when S3 =>
		Position <= 3;
		if (I(3)='1') then
			QPLUS <= S3;
		elsif (I(3)='0') and (I(2)='1') then
			QPLUS <= S2;
		elsif (I(3)='0') and (I(2)='0') and (I(1)='1')then
			QPLUS <= S1;
		elsif (I(3)='0') and (I(2)='0') and (I(1)='0') and (I(0)='1')then
			QPLUS <= S0;
		end if;
	
	end case;
	end process;
	
	
	
	
	process (CLK)
	begin
		if CLK'event and CLK = '1' then
		Q <= QPLUS;
		end if;
	end process;
	
	Process (Position)
	begin
	O_ard <= std_logic_vector(to_unsigned(Position, 2));
	end process;
	
	
	process(PARK)
	begin
	if (PARK = '1') then 
		Parkout<='1';
	else
		Parkout<='0';
	end if;
	end process;
	
	process(I)
	begin
	if (I= "0000") then
	BRAKE <= '1';
	elsif (PARK='1') and (Position=3) then
	BRAKE <= '1';
	else 
	BRAKE <= '0';
	end if;
	end process;
	
end FUNTIONALITY;