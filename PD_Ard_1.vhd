
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;



entity PD_Ard_1 is
	port (CLK : in std_logic;
			I : in  std_logic_vector(3 downto 0); -- output from the LDR Circuit as the Input to Helium Board
			O_ard : out std_logic_vector(1 downto 0); -- Binary of the Next_Position
			--O_Disp: out std_logic_vector(3 downto 0); -- output from the Helium board that indicates the current lane of the car
			BRAKE : out std_logic;					  -- output from the Helium Board that indicates the Brake
			--SEL : in std_logic := '0';                    -- Selection between output = onehotcode of next position or outpt
			PARK : in std_logic := '0';				--select between PARK mode and DRIVE Mode    PARK mode when '1', DRIVE mode when '0'
			--Dp : out std_logic := '1'
			LEFTSHIFT, RIGHTSHIFT : out std_logic := '0';
			parkout : out std_logic := '0'
			);
	
end PD_Ard_1;

architecture FUNTIONALITY of PD_Ard_1 is
	
	signal Current_Position, Next_Position : integer range 0 to 3 := 0 ;
	
begin
	
	process (I, PARK, Current_Position)
	begin
	
	if (I = "0000") or ((PARK = '1') and (Current_Position=3))then
		Next_Position <= Current_Position;
		BRAKE <= '1';
	else
		BRAKE <= '0';
	end if;
	
	
	if (PARK = '0') then
		if Current_Position = 0 then
			if (I(0)='1') then
				Next_Position <= 0;
			elsif (I(0)='0') and (I(1)='1') then
				Next_Position <= 1;
			elsif (I(0)='0') and (I(1)='0') and (I(2)='1')then
				Next_Position <= 2;
			elsif (I(0)='0') and (I(1)='0') and (I(2)='0') and (I(3)='1')then
				Next_Position <= 3;
			end if;
		
		elsif Current_Position = 1 then
			if (I(1)='1') then
				Next_Position <= 1;
			elsif (I(1)='0') and (I(0)='1') then
				Next_Position <= 0;
			elsif (I(1)='0') and (I(0)='0') and (I(2)='1')then
				Next_Position <= 2;
			elsif (I(1)='0') and (I(0)='0') and (I(2)='0') and (I(3)='1')then
				Next_Position <= 3;
			end if;
    
		elsif Current_Position = 2 then
			if (I(2)='1') then
				Next_Position <= 2;
			elsif (I(2)='0') and (I(1)='1') then
				Next_Position <= 1;
			elsif (I(2)='0') and (I(1)='0') and (I(3)='1')then
				Next_Position <= 3;
			elsif (I(2)='0') and (I(1)='0') and (I(3)='0') and (I(0)='1')then
				Next_Position <= 0;
			end if;
		
		elsif Current_Position = 3 then
			if (I(3)='1') then
				Next_Position <= 3;
			elsif (I(3)='0') and (I(2)='1') then
				Next_Position <= 2;
			elsif (I(3)='0') and (I(2)='0') and (I(1)='1')then
				Next_Position <= 1;
			elsif (I(3)='0') and (I(2)='0') and (I(1)='0') and (I(0)='1')then
				Next_Position <= 0;
			end if;
		
		end if;
	else --------------------------------------------------------------------PARK MODE
		if Current_Position = 0 then
			if (I(0)='1') then
				Next_Position <= 0;
			elsif (I(0)='0') and (I(1)='1') then
				Next_Position <= 1;
			elsif (I(0)='0') and (I(1)='0') and (I(2)='1')then
				Next_Position <= 2;
			elsif (I(0)='0') and (I(1)='0') and (I(2)='0') and (I(3)='1')then
				Next_Position <= 3;
			end if;
		
		elsif Current_Position = 1 then
			if (I(1)='1') then
				Next_Position <= 1;
			elsif (I(1)='0') and (I(2)='1') then
				Next_Position <= 2;
			elsif (I(1)='0') and (I(2)='0') and (I(0)='1')then
				Next_Position <= 0;
			elsif (I(1)='0') and (I(0)='0') and (I(2)='0') and (I(3)='1')then
				Next_Position <= 3;
			end if;
    
		elsif Current_Position = 2 then
			if (I(2)='1') then
				Next_Position <= 2;
			elsif (I(2)='0') and (I(3)='1') then
				Next_Position <= 3;
			elsif (I(2)='0') and (I(3)='0') and (I(1)='1')then
				Next_Position <= 1;
			elsif (I(2)='0') and (I(1)='0') and (I(3)='0') and (I(0)='1')then
				Next_Position <= 0;
			end if;
		
		elsif Current_Position = 3 then
		
		
		end if;
		
	end if;
	end process;
	
	process (Current_Position, Next_Position)
	begin
		if Current_Position > Next_Position then
			LEFTSHIFT <= '0'; RIGHTSHIFT <= '1';
		elsif Current_Position < Next_Position then
			LEFTSHIFT <= '1'; RIGHTSHIFT <= '0';
		end if;
	end process;
	
	process (CLK)
	begin
		if CLK'event and CLK = '1' then
			Current_Position <= Next_Position;
		end if;
	end process;
	
	Process (Next_Position)
	begin
		O_ard <= std_logic_vector(to_unsigned(Next_Position, 2));
	end process;
	
	process(PARK)
	begin
	if (PARK = '1') then 
		Parkout<='1';
	else
		Parkout<='0';
	end if;
	end process;
	
	
end FUNTIONALITY;