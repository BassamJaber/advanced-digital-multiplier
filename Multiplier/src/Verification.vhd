-------------------------------------------------------------------------------
--
-- Title       : Verification
-- Design      : Multiplier
-- Author      : Bassam Jaber
-- Company     : Birzeit University
--
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Verification IS	
  CONSTANT N: INTEGER:=8;
END Verification;

ARCHITECTURE Verification OF Verification IS  	
SIGNAL Expected ,RealResult:std_logic_vector(N+3 DOWNTO 0):=(OTHERS =>'0');
SIGNAL A :std_logic_vector( N-1 DOWNTO 0):=(OTHERS =>'0');
SIGNAL B :std_logic_vector( 3 DOWNTO 0 ):=(OTHERS =>'0');
SIGNAL clk:std_logic:='1';

BEGIN 				 
	--110 Ns for LOOK ahead	 155 for Ripple Adder
    clk <= NOT clk AFTER 155 NS;		
	g1: ENTITY work.TestGenerator(simple)GENERIC MAP (N)  PORT MAP(A , B , Expected);

	g2: ENTITY work.System(simple)GENERIC MAP (N) PORT MAP (A , B ,RealResult, clk );

	g3: ENTITY work.Analyzer(simple) GENERIC MAP( N ) PORT MAP( Expected, RealResult);	
		
END ARCHITECTURE Verification;	  


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;  
--packages that used for writing on files 
USE std.textio.ALL;
USE IEEE.std_logic_textio.ALL;

ENTITY Analyzer IS 	 	  
    GENERIC (  N:positive:=8); 
	PORT(ExpectedResult:IN std_logic_vector( N+3 DOWNTO 0):=(OTHERS =>'0');
	      RealResult: IN std_logic_vector(N +3 DOWNTO 0):=(OTHERS =>'0'));
END ENTITY Analyzer;
								  						  
ARCHITECTURE simple OF Analyzer IS	 
SIGNAL Expected , RealRes : std_logic_vector( N+3 DOWNTO 0):=(OTHERS =>'0');
BEGIN
	
	Expected ( N+3 DOWNTO 0 ) <= ExpectedResult(N+3 DOWNTO 0);
	RealRes( N+3 DOWNTO 0 ) <= RealResult;
	
	--hstr give String in Hexadecimal , 
	--str give only String
	PROCESS	 
	  FILE my_output : TEXT OPEN WRITE_MODE IS "file_io.out";  --name of the output file 
      VARIABLE my_line : LINE;
      VARIABLE my_output_line : LINE;
	BEGIN 	  
		--this Part is Handling Writting Errors and Warning to File 
		IF( Expected /= RealRes) THEN
        write(my_line, string'("writing file"));
        writeline(output, my_line);
        write(my_output_line, string'("Error : Result Mismatch"));
        writeline(my_output, my_output_line);  
		END IF;
		--310 for Ripple  
	    --220 for Look Ahead
		WAIT FOR 310 ns;
		ASSERT(Expected = RealRes)
		REPORT"Error :Mismatch Output" 
		SEVERITY ERROR;
    END PROCESS;
	
END ARCHITECTURE simple;


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;   
USE IEEE.std_logic_arith.ALL;

ENTITY TestGenerator IS			
	GENERIC(N:positive:=8);
	PORT(A:OUT std_logic_vector(N-1 DOWNTO 0):=(OTHERS =>'0');
	     B:OUT std_logic_vector(3 DOWNTO 0 ):=(OTHERS =>'0');	
		 ExpectedResult:OUT std_logic_vector( N+3 DOWNTO 0):=(OTHERS =>'0'));
END ENTITY TestGenerator;

ARCHITECTURE simple OF TestGenerator IS 
SIGNAL Ai:	std_logic_vector(N-1 DOWNTO 0):= (OTHERS =>'0');
SIGNAL Bi :std_logic_vector(3 DOWNTO 0) :=(OTHERS =>'0');	  
SIGNAL result: std_logic_vector ( N+3 DOWNTO 0):=(OTHERS =>'0');   

BEGIN  
	A(N-1 DOWNTO 0) <= Ai(N-1 DOWNTO 0);
	B(3 DOWNTO 0 ) <= Bi(3 DOWNTO 0); 
	ExpectedResult(N+3 DOWNTO 0) <= result( N+3 DOWNTO 0);
	
	PROCESS	 	
	VARIABLE x,y,r:integer:=0;
	BEGIN
	g1: FOR i IN 0 TO 2**4 -1 LOOP
		g2: FOR j IN 0 TO 2**N-1 LOOP	
			Ai <=conv_std_logic_vector(x,8);	
			r:= x*y;   	 				 
			WAIT FOR 310 ns;	 
			--220for  Carry look Ahead Adder
		   -- WAIT FOR 310 ns;	  -- for Ripple Adder
			result <= conv_std_logic_vector(r,12);
			 x := x+1;	  	 
			 -- we Generate a Test Case each a Certain Delay which is needed by the Multiplier to 
			 --	give results with out glitches we add +1 Ns for Tollerance 
		END LOOP g2;	
		      x:=0;	
			  y := y+1;	
		      Bi <= conv_std_logic_vector(y,4);   
	END LOOP g1; 
	
	END PROCESS;
END ARCHITECTURE simple;


