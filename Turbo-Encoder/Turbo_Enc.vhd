library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Enc1;
use work.interleaver;


entity Turbo_Enc is
    generic (
        m: integer := 4; -- size of the input message vector 
        mu: integer := 2       
    );
    Port ( 
        
        --f: out bit; --flag to indicate the completion of the codeword
        clk, reset: in std_logic
    );
end Turbo_Enc;

architecture TE_Arch of Turbo_Enc is
    --signal w: std_logic_vector(0 to 2);
    COMPONENT vio_0
  PORT (
    clk : IN STD_LOGIC;
    probe_in0 : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
    probe_out0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
END COMPONENT;
    signal u: std_logic_vector(0 to m-1);
    signal v: std_logic_vector(0 to 3*m - 1);
    signal a: std_logic_vector(0 to m-1); -- for input of RSC1
    signal b: std_logic_vector(0 to (2*(m+mu)-1)); -- for outputs of RSC1
    signal c: std_logic_vector(0 to m-1); -- for input of RSC2
    signal d: std_logic_vector(0 to (2*(m+mu)-1)); -- for outputs of RSC2
    signal u_pi: std_logic_vector(0 to m-1);
    
    -- components' declaratiom
    component Enc1 is 
        generic(
        k : integer := 16;
        mu: integer := 2;
        n : integer := 36; 
        r : integer := 2
    );
        Port (
            u: in std_logic_vector(0 to k-1);
            v: out std_logic_vector(0 to (2*(k + mu) - 1));
            clk, reset: in std_logic
        );
    end component Enc1;
    
    component interleaver is 
        generic(
        s : integer := 2;
        m : integer := 16
    );
        Port (
            u : in std_logic_vector(0 to m-1);
            w : out std_logic_vector(0 to m-1)
          --  clk: in std_logic
        );
    end component interleaver;
    
begin
    pi: interleaver generic map (m => m) port map(u => u, w => u_pi);
    RSC1: Enc1 generic map (k => m) port map(u => u, v => b, clk => clk, reset => reset);
    RSC2: Enc1 generic map (k => m) port map(u => u_pi, v => d, clk => clk, reset => reset);   
    --f <= '0'; 
    TE_proc: process (u, reset, b, d)         
        variable v_var: std_logic_vector(0 to 3*m-1) := (others => '0');
        variable k1: integer := 0;
        begin 
            if (reset = '1') then
                v <= (others => '0');
            else
                k1 := 0;
                for i in 0 to m-1 loop                    
                    v_var(k1) := u(i);
                    v_var(k1+1) := b(2*i+1);
                    v_var(k1+2) := d(2*i+1);
                    k1 := k1 + 3;                
                end loop;  
                v <= v_var; 
                --f <= '1';                     
            end if;   
                     
    end process TE_proc;
    your_instance_name : vio_0
  PORT MAP (
    clk => clk,
    probe_in0 => v,
    probe_out0 =>u 
  );          
end TE_Arch;
