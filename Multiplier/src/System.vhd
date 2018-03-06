-------------------------------------------------------------------------------
--
-- Title       : Complete System
-- Design      : Multiplier
-- Author      : Bassam Jaber
-- Company     : Birzeit University
--
-------------------------------------------------------------------------------

-- this part is representing the System of Multiplier 
-- connected with Registers on the inputs and the outputs
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY System IS  	 
	GENERIC (N:Positive :=8);
    PORT(A:IN std_logic_vector(N-1 DOWNTO 0);
	     B: IN std_logic_vector(3 DOWNTO 0)	;
		 S: OUT std_logic_vector(N+3 DOWNTO 0):=(others =>'0');
		 clk:IN std_logic);
END ENTITY System;

ARCHITECTURE simple OF System IS	
SIGNAL AReg:  std_logic_vector(N-1 DOWNTO 0):=(others =>'0');
SIGNAL BReg : std_logic_vector(3 DOWNTO 0):=(others =>'0');
SIGNAL SReg : std_logic_vector(N+3 DOWNTO 0):=(others =>'0'); 

BEGIN  

    AReg(N-1 DOWNTO 0) <= A(N-1 DOWNTO 0);   
	BReg( 3 DOWNTO 0) <= B( 3 DOWNTO 0);   
	g1:ENTITY work.Multiplier(simple)generic map (N) PORT MAP(AReg,BReg,SReg); 
		
	PROCESS(clk)
	BEGIN 
         IF( rising_edge(clk) )THEN			
	        --  Take Value of output Register  to Output
			-- clock will have minimum Frequency Needed for the Multiplier .  
			S(N+3 DOWNTO 0) <= SReg( N+3 DOWNTO 0);	
		END IF;		
	END PROCESS;

END ARCHITECTURE simple;


