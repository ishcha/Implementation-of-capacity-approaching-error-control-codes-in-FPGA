

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TE_tb is
--  Port ( );
end TE_tb;

architecture tb_Arch of TE_tb is
    -- component instantiation
    component Turbo_Enc 
--        generic (
--            m: integer := 4 -- size of the input message vector        
--        );
        Port ( 
            u: in std_logic_vector(0 to 4-1);
            v: out std_logic_vector(0 to 3*4 - 1);
            --f: out bit;
            clk, reset: in std_logic
        );
    end component Turbo_Enc;
    
    -- clock parameters: clock period is kept smaller as it is only involved in the computation of individual bits.
    constant T: time := 5ns; -- clock period
    signal clock: std_logic := '0';
    signal reset: std_logic := '0';
    
    -- data signals 
    constant m_tb: integer := 4;
    signal u_tb: std_logic_vector(0 to m_tb - 1);
    signal v_tb: std_logic_vector(0 to 3*m_tb - 1);
    --signal f_tb: bit;
    signal check: std_logic_vector(0 to 3*m_tb - 1);
    
begin
    -- DUT instantiation
    DUT: Turbo_Enc 
--        generic map (
--            m => m_tb
--        )
        port map (
            u => u_tb,
            v => v_tb,
            --f => f_tb,
            clk => clock,
            reset => reset
        );
        
    -- clock generator        
    clk_gen: process
        begin 
            clock <= '0';
            wait for T/2;
            clock <= '1';
            wait for T/2;
    end process clk_gen;  
    
    -- reset generation
    reset <= '1', '0' after 5ns; 
    
    test_proc: process 
        variable line_o: line;
    begin 
        wait until falling_edge(reset); -- wait for reset
        u_tb <= "1011"; --0001001111101000
--        wait until (f_tb = '1');
--        check <= "000000000110011010110111100111111010100011001011";
        wait until falling_edge(clock);
        
    end process test_proc;                         

end tb_Arch;
