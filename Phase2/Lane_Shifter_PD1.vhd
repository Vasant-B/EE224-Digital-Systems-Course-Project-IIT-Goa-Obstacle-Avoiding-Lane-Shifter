--DLD Project Self Lane shifting car
--Vasant, Manika, Vaishnavi, Sidhart
-- updated on 19th March 2018

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity Lane_Shifter_PD1 is
	port (CLK : in std_logic;
			I : in  std_logic_vector(3 downto 0); -- output from the LDR Circuit as the Input to Helium Board
			O_Disp: out std_logic_vector(3 downto 0); -- output from the Helium board that indicates the current lane of the car
			BRAKE : inout std_logic;					  -- output from the Helium Board that indicates the Brake
			SEL : in std_logic := '0';                    -- Selection between output = onehotcode of next position or outpt
			PARK : in std_logic := '0';				--select between PARK mode and DRIVE Mode    PARK mode when '1', DRIVE mode when '0'
			Dp : out std_logic := '1'
			);
	
end Lane_Shifter_PD1;

architecture FUNTIONALITY of Lane_Shifter_PD1 is
	
	signal Current_Position, Next_Position : integer range 0 to 3 := 0 ;
	signal O : std_logic_vector(3 downto 0);
	signal outpt : std_logic_vector(3 downto 0) := "0001";
	
	
begin
	Process (I, Current_Position)
	begin
	if PARK = '0' then
		if Current_Position = 0 then
			if I = "0000" then
				BRAKE <= '1';
				Next_Position <= 0;
				outpt <= "0000";
			elsif (I = "0001")or(I = "0011")or(I = "0101")or(I = "0111")or(I = "1001")or(I = "1011")or(I = "1101")or(I = "1111") then ---XXX1
				BRAKE <= '0';
				Next_Position <= 0;
				outpt <= "0001";
			elsif (I = "0010")or(I = "0110")or(I = "1010")or(I = "1110") then --XX10
				BRAKE <= '0';
				Next_Position <= 1;
				outpt <= "0010";
			elsif (I = "0100")or(I = "1100") then --X100
				BRAKE <= '0';
				Next_Position <= 2;
				outpt <= "0100";
			elsif I = "1000" then
				BRAKE <= '0';
				Next_Position <= 3;
				outpt <= "1000";
			end if; --I
				
		elsif Current_Position = 1 then
			if I = "0000" then
				BRAKE <= '1';
				Next_Position <= 1;
				outpt <= "0000";
			elsif (I = "0010")or(I = "0110")or(I = "1010")or(I = "1110")or(I = "0011")or(I = "0111")or(I = "1011")or(I = "1111") then--XX1X
				BRAKE <= '0';
				Next_Position <= 1;
				outpt <= "0010";
			elsif (I = "0001")or(I = "0101")or(I = "1001")or(I = "1101") then --XX01
				BRAKE <= '0';
				Next_Position <= 0;
				outpt <= "0001";
			elsif (I = "0100")or(I = "1100") then --X100
				BRAKE <= '0';
				Next_Position <= 2;
				outpt <= "0100";
			elsif I = "1000" then
				BRAKE <= '0';
				Next_Position <= 3;
				outpt <= "1000";
			end if; --I
		
		elsif Current_Position = 2 then
			if I = "0000" then
				BRAKE <= '1';
				Next_Position <= 2;
				outpt <= "0000";
			elsif (I = "0100")or(I = "0101")or(I = "0110")or(I = "0111")or(I = "1100")or(I = "1101")or(I = "1110")or(I = "1111") then --X1XX
				BRAKE <= '0';
				Next_Position <= 2;
				outpt <= "0100";
			elsif (I = "0010")or(I = "0011")or(I = "1010")or(I = "1011") then --X01X
				BRAKE <= '0';
				Next_Position <= 1;
				outpt <= "0010";
			elsif (I = "1000")or(I = "1001") then --100X
				BRAKE <= '0';
				Next_Position <= 3;
				outpt <= "1000";
			elsif I = "0001" then
				BRAKE <= '0';
				Next_Position <= 0;
				outpt <= "0001";
			end if; --I
			
		elsif Current_Position = 3 then
			if I = "0000" then
				BRAKE <= '1';
				Next_Position <= 3;
				outpt <= "0000";
			elsif (I = "1000")or(I = "1001")or(I = "1010")or(I = "1011")or(I = "1100")or(I = "1101")or(I = "1110")or(I = "1111") then --1XXX
				BRAKE <= '0';
				Next_Position <= 3;
				outpt <= "1000";
			elsif (I = "0100")or(I = "0101")or(I = "0110")or(I = "0111") then --01XX
				BRAKE <= '0';
				Next_Position <= 2;
				outpt <= "0100";
			elsif (I = "0010")or(I = "0011") then --001X
				BRAKE <= '0';
				Next_Position <= 1;
				outpt <= "0010";
			elsif I = "0001" then
				BRAKE <= '0';
				Next_Position <= 0;
				outpt <= "0001";
			end if; --I	
		end if;  --current position loop
		
	elsif PARK = '1' then             ------------------------------------PARK MODE
		if Current_Position = 0 then
			if I = "0000" then
				BRAKE <= '1';
				Next_Position <= 0;
				outpt <= "0000";
			elsif (I = "0001")or(I = "0011")or(I = "0101")or(I = "0111")or(I = "1001")or(I = "1011")or(I = "1101")or(I = "1111") then ---XXX1
				BRAKE <= '0';
				Next_Position <= 0;
				outpt <= "0001";
			elsif (I = "0010")or(I = "0110")or(I = "1010")or(I = "1110") then --XX10
				BRAKE <= '0';
				Next_Position <= 1;
				outpt <= "0010";
			elsif (I = "0100")or(I = "1100") then --X100
				BRAKE <= '0';
				Next_Position <= 2;
				outpt <= "0100";
			elsif I = "1000" then
				BRAKE <= '0';
				Next_Position <= 3;
				outpt <= "1000";
			end if; --I
				
		elsif Current_Position = 1 then
			if I = "0000" then
				BRAKE <= '1';
				Next_Position <= 1;
				outpt <= "0000";
			elsif (I = "0010")or(I = "0110")or(I = "1010")or(I = "1110")or(I = "0011")or(I = "0111")or(I = "1011")or(I = "1111") then--XX1X
				BRAKE <= '0';
				Next_Position <= 1;
				outpt <= "0010";
			elsif (I = "0100")or(I = "0101")or(I = "1100")or(I = "1101") then --X10X
				BRAKE <= '0';
				Next_Position <= 2;
				outpt <= "0100";
			elsif (I = "0001")or(I = "1001") then --X001
				BRAKE <= '0';
				Next_Position <= 0;
				outpt <= "0001";
			elsif I = "1000" then
				BRAKE <= '0';
				Next_Position <= 3;
				outpt <= "1000";
			end if; --I
		
		elsif Current_Position = 2 then
			if I = "0000" then
				BRAKE <= '1';
				Next_Position <= 2;
				outpt <= "0000";
			elsif (I = "0100")or(I = "0101")or(I = "0110")or(I = "0111")or(I = "1100")or(I = "1101")or(I = "1110")or(I = "1111") then --X1XX
				BRAKE <= '0';
				Next_Position <= 2;
				outpt <= "0100";
			elsif (I = "1000")or(I = "1001")or(I = "1010")or(I = "1011") then --10XX
				BRAKE <= '0';
				Next_Position <= 3;
				outpt <= "1000";
			elsif (I = "0010")or(I = "0011") then --001X
				BRAKE <= '0';
				Next_Position <= 2;
				outpt <= "0010";
			elsif I = "0001" then
				BRAKE <= '0';
				Next_Position <= 0;
				outpt <= "0001";
			end if; --I
			
		elsif Current_Position = 3 then  --------- if Current_Position = 3 then it is n the leftmost lane and it should apply brakes
			--if I = "0000" then
				BRAKE <= '1';
				Next_Position <= 3;
				outpt <= "1000";
			--elsif (I = "1000")or(I = "1001")or(I = "1010")or(I = "1011")or(I = "1100")or(I = "1101")or(I = "1110")or(I = "1111") then --1XXX
			--	BRAKE <= '0';
			--	Next_Position <= 3;
			--	outpt <= "1000";
			--elsif (I = "0100")or(I = "0101")or(I = "0110")or(I = "0111") then --01XX
			--	BRAKE <= '0';
			--	Next_Position <= 2;
			--	outpt <= "0100";
			--elsif (I = "0010")or(I = "0011") then --001X
			--	BRAKE <= '0';
			--	Next_Position <= 1;
			--	outpt <= "0010";
			--elsif I = "0001" then
			--	BRAKE <= '0';
			--	Next_Position <= 0;
			--	outpt <= "0001";
			--end if; --I	
		end if;  --current position loop
	end if; --loop to select between park or drive
	end process; -- (Current_Position, I) gives out BRAKE and Next_Position
	
	process (CLK)
	begin
		if CLK'event and CLK = '1' then
			Current_Position <= Next_Position;
		end if;
	end process;  -- (CLK) and gives the funtionality of assigning the Next position to the Current position variable.
	
	
	Process (SEL, Next_Position)
	begin
	if SEL = '0' then
		case Next_Position is
		when 0 => 
					O <= "0001";
		when 1 => 
					O <= "0010";
		when 2 => 
					O <= "0100";
		when 3 => 
					O <= "1000";
		when others =>
					O <= "0000";
		end case;
	elsif SEL = '1' then
		O <= outpt;
	end if;
	end process;
	
	process(BRAKE, O)
	begin
	if (BRAKE = '1') then 
		O_disp(3 downto 0) <= "0000";
	else
		O_disp(0) <= not O(0);
		O_disp(1) <= not O(1);
		O_disp(2) <= not O(2);
		O_disp(3) <= not O(3);
	end if;
	end process;
	
end FUNTIONALITY;