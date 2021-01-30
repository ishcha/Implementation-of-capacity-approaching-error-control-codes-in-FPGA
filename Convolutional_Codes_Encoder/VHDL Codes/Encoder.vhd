library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Encoder is
    generic(    
        k : integer := 4;
        mu: integer := 2;
        n : integer := 36; 
        r : integer := 2
    );
    Port (
        
        clk, reset: in std_logic
    );
end entity Encoder;

architecture RSC_Arch of Encoder is
    --signal state: std_logic_vector(1 to 2) := "00";
--    signal i: integer := 0;

    signal u: std_logic_vector(0 to k-1);
    signal v: std_logic_vector(0 to (2*(k + mu) - 1));
    COMPONENT vio_0
      PORT (
        clk : IN STD_LOGIC;
        probe_in0 : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        probe_out0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
      );
    END COMPONENT;
begin
    clk_proc: process (reset, u)
    variable state: std_logic_vector(1 to 2) := "00";
    --variable i: integer := 0;
    variable v_var: std_logic_vector(0 to (2*(k + mu) - 1));
    begin
        state := "00";
        if (reset = '1') then
            
            v <= (others => '0');
            --i := 0;
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
    your_instance_name : vio_0
  PORT MAP (
    clk => clk,
    probe_in0 => v,
    probe_out0 => u
  );
end RSC_Arch;
