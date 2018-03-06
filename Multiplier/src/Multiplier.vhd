-------------------------------------------------------------------------------
--
-- Title       : Multiplier
-- Design      : Multiplier
-- Author      : Bassam Jaber
-- Company     : Birzeit University
--
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Multiplier IS   
	Generic(N:Positive:=8);  
	Port(A:in std_logic_vector(N-1 downto 0);
	     B: in std_logic_vector(3 downto 0)	;
		 S: out std_logic_vector(N+3 downto 0) ); 
END ENTITY Multiplier;			

--Architecture of Multiplier
ARCHITECTURE simple OF Multiplier IS  	
type TempSum is Array (N-1 downto 0 ) of std_logic_vector( 3 downto 0);
type TempInput is Array (N-2 downto 0) of std_logic_vector( 3 downto 0);

Signal cin :std_logic:='0';	
Signal cout:std_logic_vector(N-1 downto 0); 
Signal Ai,Bi:TempInput;
Signal Si : TempSum;   

BEGIN	
	--  Iterative Multiplication implemented to make it easier to trace 	
	--this loop initialize the second input by multiply first bit of A by B , to make it as an input
    -- for the 4 bit Adder , to make the process General and iterative
		
	g1: for i in 0 to 3 generate  
		g2: entity work.andGate(simple) port map ( A(0) , B(i) , Si(0)(i) );
	end generate g1; 

	cout(0) <= '0';
	
	 --Loop that Multiply A by B
	g3: for i in 0 to N-2 generate 	
		
		--each time we will multiply one bit from A with B and add the result to prevoius result of 
		--4 bit Adder and shift the sum one bit each time .
		g5: for j in 0 to 3 generate
		   g4: entity work.andGate(simple) port map (A(i+1) , B(j) , Ai(i)(j));  
	    end generate g5;  
		
		--this Represent shifting the new Value of Sum and Output the LS Bit to output result
		Bi (i) <= cout(i) & Si(i)(3 downto 1);
		S(i) <= Si(i)(0);
		
		-- add Prevoius Sum to the Result of Multiply bit i of A by 4 bit number B 	
		--entity work.RippleAdder(simple) 
		--entity work.CarryLookAheadAdder(simple)
		add: entity work.RippleAdder(simple) port map(cin, Ai(i), Bi(i) ,Si(i+1),cout(i+1));
			
	end generate g3; 	  
	
	-- After We finish we Must Move the last Result of the Adder to the Multiplication Result 
	S(N+3 downto N-1) <= cout(N-1) & Si(N-1) ( 3 downto 0);

END ARCHITECTURE simple;   


