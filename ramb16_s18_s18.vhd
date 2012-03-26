--  File: RAMB4_S18_S18.vhd

--
library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.std_logic_unsigned.all;

entity   RAMB16_S18_S18 is
	port (DIA    : in STD_LOGIC_VECTOR (15 downto 0);
		DIB    : in STD_LOGIC_VECTOR (15 downto 0);
		DIPA    : in STD_LOGIC_VECTOR (1 downto 0);
		DIPB    : in STD_LOGIC_VECTOR (1 downto 0);
		ENA    : in STD_ULOGIC;
		ENB    : in STD_ULOGIC;
		WEA    : in STD_ULOGIC;
		WEB    : in STD_ULOGIC;
		SSRA   : in STD_ULOGIC;
		SSRB   : in STD_ULOGIC;
		CLKA   : in STD_ULOGIC;
		CLKB   : in STD_ULOGIC;
		ADDRA  : in STD_LOGIC_VECTOR (9 downto 0);
		ADDRB  : in STD_LOGIC_VECTOR (9 downto 0);
		DOA    : out STD_LOGIC_VECTOR (15 downto 0);
		DOB    : out STD_LOGIC_VECTOR (15 downto 0);
		DOPA    : out STD_LOGIC_VECTOR (1 downto 0);
		DOPB    : out STD_LOGIC_VECTOR (1 downto 0)
		); 
end RAMB16_S18_S18;

architecture BEH of RAMB16_S18_S18 is
	
	type mem is array (0 to 1023) of std_logic_vector (17 downto 0);							  
	signal adra,adrb:std_logic_vector (9 downto 0):=(others=>'0');	   						  
	signal data_a,data_b:std_logic_vector (17 downto 0);
	signal wea_1,web_1: STD_LOGIC; 
begin  
	process(clka,ssra,clkb,ssrb,adra,adrb,wea,web,dia,dib)  
		variable ram: mem:=(others=>"000000000000000000") ;	
		variable ia,ib: integer;	   
		variable a,b:std_logic_vector (17 downto 0);
	begin
	
		
		ia:= conv_integer(To_X01(adra));		                 
		a:=	 ram(ia); 
		dopa<=a(17 downto 16);
		doa <= a(15 downto 0); 
		if wea_1 = '1' then
			ram(ia) :=data_a;           
		end if;	 	
		
		
		ib:= conv_integer(To_X01(adrb));  		                 
		b:=	 ram(ib); 
		dopb<=b(17 downto 16);
		dob <= b(15 downto 0);  
		if web_1 = '1' then
			ram(ib) := data_b;           
		end if;
			
		if ssra = '1' then 
			dopa<="00";
			doa <= X"0000";	 
			adra <= "0000000000";			
			wea_1 <= '0';   
		elsif clka = '1' and clka'event then 
			data_a <= dipa&dia;	
			adra(9 downto 0) <= addra;
			wea_1 <= wea;
		end if;	
		
		if ssrb = '1' then 
			dopb<="00";
			dob <= X"0000";	 	 
			adrb <= "0000000000"; 			
			web_1 <= '0';
		elsif clkb = '1' and clkb'event then 
			data_b <= dipb&dib;	
			adrb(9 downto 0)  <= addrb; 			
			web_1 <= web;
		end if;
	end process;
	
end BEH;
