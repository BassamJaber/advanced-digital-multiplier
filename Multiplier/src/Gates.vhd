-------------------------------------------------------------------------------
--
-- Title       : Gates
-- Design      : Multiplier
-- Author      : Bassam Jaber
-- Company     : Birzeit University
--
-------------------------------------------------------------------------------

--NOT GATE
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
																				 
ENTITY notGate IS  
	PORT( a: IN std_logic;
	      b:OUT std_logic);
END ENTITY notGate;

ARCHITECTURE simple OF notGate IS
BEGIN
	 b <= NOT a AFTER 3 ns;
END ARCHITECTURE simple;

--NAND GATE
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY nandGate IS  
	PORT( a,b: IN std_logic ;
	      c:OUT std_logic);
END ENTITY nandGate;

ARCHITECTURE simple OF nandGate IS
BEGIN
	 c <= a NAND b AFTER 5 ns;
END ARCHITECTURE simple;	

--NOR GATE
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY norGate IS  
	PORT( a,b: IN std_logic ;
	      c:OUT std_logic);
END ENTITY norGate;

ARCHITECTURE simple OF norGate IS
BEGIN
	 c <= a NOR b AFTER 5 ns;
END ARCHITECTURE simple;

--AND GATE
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY andGate IS  
	PORT( a,b: IN std_logic ;
	      c:OUT std_logic);
END ENTITY andGate;

ARCHITECTURE simple OF andGate IS
BEGIN
	 c <= a AND b AFTER 8 ns;
END ARCHITECTURE simple;   

--OR GATE
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY orGate IS  
	PORT( a,b: IN std_logic ;
	      c:OUT std_logic);
END ENTITY orGate;

ARCHITECTURE simple OF orGate IS
BEGIN
	 c <= a OR b AFTER 8 ns;
END ARCHITECTURE simple;   

--XOR GATE
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY xorGate IS  
	PORT( a,b: IN std_logic ;
	      c:OUT std_logic);
END ENTITY xorGate;

ARCHITECTURE simple OF xorGate IS
BEGIN
	 c <= a XOR b AFTER 11 ns;
END ARCHITECTURE simple;

--XNOR GATE 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY xnorGate IS  
	PORT( a,b: IN std_logic ;
	      c:OUT std_logic);
END ENTITY xnorGate;

ARCHITECTURE simple OF xnorGate IS
BEGIN
	 c <= a XNOR b AFTER 10 ns;
END ARCHITECTURE simple;  
