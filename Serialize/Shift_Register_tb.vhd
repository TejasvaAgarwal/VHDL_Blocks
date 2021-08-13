library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Shift_Register_tb is
--  Port ( );
end Shift_Register_tb;

architecture Behavioral of Shift_Register_tb is
    
    signal clock : std_logic ;
    signal reset : std_logic ;
    signal s_en :  std_logic ;
    signal start : std_logic ;
    signal count : std_logic_vector (4 downto 0);
    signal dir :  std_logic ;
    signal sdata : std_logic ;
    signal data : std_logic_vector (31 downto 0);
    
begin
    
    DUT : entity work.Shift_Register
    port map (
    clock => clock,
    reset => reset,
    s_en => s_en,
    start => start,
    dir => dir,
    count => count,
    data => data,
    sdata => sdata
    );
    
    start <= '1', '0' after 40 ns;
    count <= "11111";
    --data <= "10101010101010101010101010101010";
    --data <= "11111111111111111111111111111111";
    --data  <= "00000000000000000000000000000000";
    data  <= "01010001110101000111010100011101";
    dir   <= '1'; 
    process	 
    begin      
        	
        clock <= '0';			-- clock cycle is 10 ns
	    wait for 5 ns;
	    clock <= '1';
        wait for 5 ns;

    end process;
    
    process	 
    begin      
        	
        s_en <= '0';			-- clock cycle is 10 ns
	    wait for 50 ns;
	    s_en <= '1';
        wait for 5 ns;

    end process;

end Behavioral;
