-------------------------------------------------------------------------------
--
-- Title       : Carry Look Ahead Adder
-- Design      : Multiplier
-- Author      : Bassam Jaber
-- Company     : Birzeit University
--
-------------------------------------------------------------------------------

-- CARRY LOOK AHEAD GENERATOR
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY CarryLookAheadGenerator IS
	PORT(cin: IN std_logic;
	     P,G : IN std_logic_vector(3 DOWNTO 0);	  
		 C : OUT std_logic_vector(4 DOWNTO 0));
END ENTITY CarryLookAheadGenerator;	 

ARCHITECTURE simple OF CarryLookAheadGenerator IS	
SIGNAL Ci:std_logic_vector (4 DOWNTO 0):="00000";
SIGNAL n :std_logic_vector ( 3 DOWNTO 0):="0000";

BEGIN	   

	Ci(0) <= cin;   		 	
	
	--generate Ci+1 using Pi , and Ci amd Gi
	g1: FOR i IN 0 TO 3 GENERATE  
		g2:ENTITY work.andGate(simple) PORT MAP( P(i) , Ci(i), n(i)); 
		g3:ENTITY work.orGate(simple) PORT MAP ( n(i) , G(i) , Ci(i+1));
	END GENERATE g1; 
				
	C ( 4 DOWNTO 0 ) <= Ci(4 DOWNTO 0);	
	
END ARCHITECTURE simple;	   

--CARRY LOOK AHEAD ADDER
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY CarryLookAheadAdder IS
	PORT( cin :IN std_logic;
	      A,B :IN std_logic_vector(3 DOWNTO 0);	 
		  S: OUT std_logic_vector(3 DOWNTO 0);
		  cout: OUT std_logic );
END ENTITY CarryLookAheadAdder;	

ARCHITECTURE simple OF CarryLookAheadAdder IS	 
SIGNAL Pi,Gi,Si : std_logic_vector(3 DOWNTO 0):="0000";	   
SIGNAL Ci : std_logic_vector(4 DOWNTO 0):="00000";
BEGIN 	
	
	--connecting all parts together depending on the Design
	g1: FOR i IN 0 TO 3 GENERATE
		g2:ENTITY work.xorGate(simple) PORT MAP (A(i) , B(i) , Pi(i));
		g3:ENTITY work.andGate(simple) PORT MAP( A(i) , B(i) , Gi(i));
	END GENERATE g1; 
	
	g4: ENTITY work.CarryLookAheadGenerator(simple) PORT MAP (cin , Pi , Gi , Ci );  
		
	g5: FOR i IN 0 TO 3 GENERATE
		g6: ENTITY work.xorGate(simple) PORT MAP(Ci(i) , Pi(i) , Si(i));
	END GENERATE g5;  
	
	cout <= Ci(4);
	
	S( 3 DOWNTO 0 ) <= Si( 3 DOWNTO 0);

END ARCHITECTURE simple;



	


