library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Enc1 is
    generic(    
        k : integer := 4;
        mu: integer := 2;
        n : integer := 36; 
        r : integer := 2
    );
    Port (
         u: in std_logic_vector(0 to k-1);
         v: out std_logic_vector(0 to (2*(k + mu) - 1));
        clk, reset: in std_logic
    );
end entity Enc1;

architecture RSC_Arch of Enc1 is
    
begin
    clk_proc: process (reset, u)
    variable state: std_logic_vector(1 to 2) := "00";
    variable v_var: std_logic_vector(0 to (2*(k + mu) - 1));
    begin
        state := "00";
        if (reset = '1') then
            
            v <= (others => '0');
        else 
            for i in 0 to k-1 loop
                if ((u(i) = '0' or u(i) = '1')) then
                    v_var(2*i to (2*i + 1)) := (1 => u(i), 2 => u(i) xor state(1));
                    state := (1 => u(i) xor state(1) xor state(2), 2 => state(1)); 
                end if;
            end loop;
            
            for i in k to k+mu-1 loop
                if (v_var(2*k-1) = '0' or v_var(2*k -1) = '1') then
                    v_var(2*i to (2*i + 1)) := (1 => '0', 2 => state(1));
                    state := (1 => (state(1) xor state(2)), 2 => state(1));
                end if;
            end loop;
            
            v <= v_var;
        end if;  
        
    end process clk_proc;

end RSC_Arch;
