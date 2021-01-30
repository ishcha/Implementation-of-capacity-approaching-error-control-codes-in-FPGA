
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--use ieee.math_real.uniform;
use ieee.math_real.floor;
use ieee.math_real.sqrt;
use ieee.math_real.ceil;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;




-- S interleaver design => randomness is not given  
entity interleaver is
    generic(
        s : integer := 2;
        m : integer := 16
    );
    Port (
        u : in std_logic_vector(0 to m-1);
        w : out std_logic_vector(0 to m-1)
      --  clk: in std_logic
    );
end interleaver;

architecture S_arch of interleaver is
    type int_array is array(0 to m-1) of integer;
    signal p: int_array;
    constant d: integer :=  (m+1)/2;--TO_INTEGER(shift_left(unsigned(std_logic_vector(TO_UNSIGNED(m+1, 5))), 1));
    
begin
    clk_proc : process (u)
        variable i, j, k: integer; 
        begin
            i := 0;
            j := d;
            k := 0;
            while (i <= d-1) and (j <= m-1) loop
                w(k) <= u(i);
                k := k+1;
                i := i+1;
                w(k) <= u(j);
                k := k+1;
                j := j+1;
            end loop; 
            while (i <= d-1) loop 
                w(k) <= u(i);
                k := k+1;
                i := i+1;
            end loop;
    end process clk_proc;

end S_arch;
