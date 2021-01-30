library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_textio.all;
use std.textio.all;
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RSC_tb is
--  Port ( );
end RSC_tb;

architecture tb_Arch of RSC_tb is
    component Encoder 
--        generic(    
--            k : integer := 4;
--            mu: integer := 2;
--            n : integer := 36; 
--            r : integer := 2
--        );
        Port (
            u: in std_logic_vector(0 to 4-1);
            v: out std_logic_vector(0 to (2*(4 + 2) - 1));
            clk, reset: in std_logic
        );
    end component Encoder;
    
    constant delay : integer := 10; -- wait
    constant T     : time := 10ns; -- clock period
    signal clock   : std_logic := '0'; -- clock generator
    signal res   : std_logic := '0'; -- reset generator
    
    -- data signals
    constant k_tb: integer := 4;
    constant mu_tb : integer := 2;
    constant n_tb : integer := 36;
    constant r_tb : integer := 2;
    
    --signal u_tb : std_logic;
    signal u_vec_tb: std_logic_vector(0 to (k_tb -1 )); --assuming no need to pass input bits to force the state to be 0 for this encoder code 
    signal v_tb : std_logic_vector(0 to (2*(k_tb + mu_tb) - 1));
    --signal check: std_logic_vector(0 to r_tb*(k_tb + mu_tb)-1);
    signal flag: bit := '0';
begin
    -- DUT instantiation
    DUT: Encoder 
--        generic map(
--            k => k_tb,
--            mu => mu_tb,
--            n => n_tb,
--            r => r_tb
--        )
        port map(
            u => u_vec_tb,
            v => v_tb,
            clk => clock,
            reset => res
        );
    
    -- clock generator
    clk_gen: process begin 
    clock <= '0';
    wait for T/2;
    clock <= '1';
    wait for T/2;    
    end process clk_gen;
    
    -- reset generator
--    res_proc: process begin
    
--    end process res_proc;
    
    test_proc : process 
        variable line_o: line;
        begin 
            res <= '1';
            wait for 10ns;
            res <= '0'; -- reset signal is released after 10 nsec
            --wait until falling_edge(res); -- wait for reset to be released
            wait until rising_edge(clock); -- wait for a clock pulse
            u_vec_tb <= "1001"; --000100111110100000
            --check <= "100100010100"; --000000110101111110111101100100010100
            wait until rising_edge(clock);
            flag <= '1';           
--            u_tb <= u_vec_tb;
--            for i in 0 to k_tb-1+mu_tb loop 
                
--                wait until rising_edge(clock);
----                if (v_tb /= check(2*i to 2*i+1)) then
----                    report "count fail at time count" & time'image(now) & integer'image(i);
----                end if;                 
--            end loop; 
--            flag <= '0';
            --wait until rising_edge(clock);
            --wait until rising_edge(clock);
            for i in 0 to 10 loop
                wait until rising_edge(clock);
            end loop;
            res <= '1'; 
            wait until rising_edge(clock);
            res <= '0';-- reset signal is released after 10 nsec
            u_vec_tb <= "1111";
--            u_vec_tb <= "111100"; --000011001010010100
--            wait until rising_edge(clock);
--            flag <= '1';
--            --wait until rising_edge(clock);
--            for j in 0 to k_tb-1+mu_tb loop 
--                u_tb <= u_vec_tb(j);
--                wait until rising_edge(clock);
--                if (v_tb /= check(2*j to 2*j+1)) then
--                    report "count fail at time count" & time'image(now) & integer'image(j);
--                end if;                 
--            end loop; 
--            flag <= '0';
            wait;
    end process test_proc;

end tb_Arch;
