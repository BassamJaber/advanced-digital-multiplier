-------------------------------------------------------------------------------
--
-- Title       : Ripple Adder
-- Design      : Multiplier
-- Author      : Bassam Jaber
-- Company     : Birzeit University
--
-------------------------------------------------------------------------------

--FULL ADDER
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY fullAdder IS
	PORT(a,b,cin:IN std_logic;
     	sum,cout:OUT std_logic);
END ENTITY fullAdder;

ARCHITECTURE simple OF fullAdder IS	 
SIGNAL n, m1,m2,m3,k:std_logic;   
BEGIN	   
	
	g1:ENTITY work.xorGate(simple) PORT MAP(a,b,n);
	g2:ENTITY work.xorGate(simple) PORT MAP(cin,n,sum);
	g3:ENTITY work.andGate(simple) PORT MAP(a,b,m1);
	g4:ENTITY work.andGate(simple) PORT MAP(a,cin,m2);
	g5:ENTITY work.andGate(simple) PORT MAP(b,cin,m3); 
	g6:ENTITY work.orGate(simple)  PORT MAP(m1,m2,k);
	g7:ENTITY work.orGate(simple)  PORT MAP(k,m3,cout);	  
		
END ARCHITECTURE simple; 

--RIPPLE ADDER
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY RippleAdder IS
	PORT (  cin:  IN STD_LOGIC;
	        a, b: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            sum: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		    cout: OUT STD_LOGIC); 
END ENTITY RippleAdder;

--Iterative Implementation of 4 bit Ripple Adder
ARCHITECTURE simple OF RippleAdder IS
SIGNAL carry: STD_LOGIC_VECTOR(4 DOWNTO 0);
BEGIN
    carry(0) <= cin;
    cout <= carry(4);
    g1: FOR i IN 0 TO 3 GENERATE  
	     g2:  ENTITY work.fullAdder(simple) 
       PORT MAP (carry(i),a(i),b(i),sum(i),carry(i+1));
     END GENERATE g1;
END ARCHITECTURE simple; 
