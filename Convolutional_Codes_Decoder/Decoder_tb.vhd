library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.textio.all;
use ieee.std_logic_textio.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VD_tb is
--  Port ( );
end VD_tb;

architecture tb_arch of VD_tb is
    component Viterbi_decoder
--        generic(
--            mu: integer := 2; -- number of encoder states
--            rs: integer := 16; -- size of received vector
--            n: integer := 2
--        ); 
        port(
            r: in std_logic_vector(0 to (16-1));
            v: out std_logic_vector(0 to (16-1));
            u: out std_logic_vector(0 to ((16/2) - 1));
            clk, reset: in std_logic
        );
    end component Viterbi_decoder;
    
    constant delay : integer := 10; -- wait
    constant rs_tb: integer := 16;
    constant mu_tb: integer := 2;
    constant n_tb: integer := 2;
    constant T     : time := 20ns; -- clock period
    signal clock   : std_logic := '0'; -- clock generator
    signal res     : std_logic := '0'; -- reset generator
    
    -- data signals
    signal r_tb : std_logic_vector(0 to (rs_tb-1)) := "0111101000111000"; -- input 001110
    signal v_tb : std_logic_vector(0 to (rs_tb-1)) := (others => '0'); -- output codeword
    signal u_tb: std_logic_vector(0 to ((rs_tb/2)-1)) := (others => '0');
    signal check: std_logic_vector(0 to (rs_tb-1)) := (others => '0'); -- to compare 
begin
    -- DUT instantiation
    DUT: Viterbi_decoder 
--    generic map (
--        mu => mu_tb,
--        rs => rs_tb,
--        n => n_tb
--    )
    port map (
        r => r_tb,
        v => v_tb,
        u => u_tb,
        clk => clock,
        reset => res
    );
    
    -- clock generator
--    clk_gen : process begin
--        clock <= '0';
--        wait for T/2;
--        clock <= '1';
--        wait for T/2;
--    end process clk_gen;

    -- clock generator
    clk_gen: process begin 
    clock <= '0';
    wait for T/2;
    clock <= '1';
    wait for T/2;    
    end process clk_gen;

    -- reset generator
    res <= '1', '0' after 10 ns; -- reset signal is released after 10 nsec
    
    test_proc : process 
        --variable line_o: line;
    begin
        wait until falling_edge(res);  -- wait for reset signal to be released
        wait until falling_edge(clock); -- wait for a clock pulse
        r_tb <= "0111101000111000"; --001110
        --check <= "0011101000011100"; --000111
        --wait until falling_edge(clock);        
--        if (v_tb /= check) then
--            write(line_o, string'("ERROR"));
--            write(line_o, v_tb);
--            writeline (output, line_o);
--        end if;
        
        wait;
        
    end process test_proc;
    
end tb_arch;
