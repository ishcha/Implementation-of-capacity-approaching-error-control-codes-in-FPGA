
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--use STD.textio.all;

entity Viterbi_decoder is
    generic (
        mu: integer := 2; -- number of encoder states bits
        rs: integer := 16; -- size of received vector
        n: integer := 2 -- number of output bits per input info bit
    );
    port(
--        r: in std_logic_vector(0 to (rs-1)); --received vector
--        v: out std_logic_vector(0 to (rs-1)); -- output codeword
--        u: out std_logic_vector(0 to ((rs/2) - 1));
        clk, reset: in std_logic 
    );
end entity Viterbi_decoder;

architecture arch of Viterbi_decoder is

COMPONENT vio_0
  PORT (
    clk : IN STD_LOGIC;
    probe_in0 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    probe_in1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    probe_out0 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END COMPONENT;
        signal r: std_logic_vector(0 to (rs-1)); --received vector
        signal v: std_logic_vector(0 to (rs-1)); -- output codeword
        signal u: std_logic_vector(0 to ((rs/2) - 1));
    
    constant s: integer := 2**mu; 
    type int_array is array(0 to s-1) of integer;
    type paths is array(0 to s-1) of std_logic_vector(0 to rs-1); 
    type mpaths is array(0 to s-1) of std_logic_vector(0 to ((rs/2)-1));
    type double_int is array(0 to 3) of std_logic_vector(0 to 1); 
    constant st: double_int := ("00", "01", "10", "11"); 
--    COMPONENT vio_3
--  PORT (
--    clk : IN STD_LOGIC;
--    probe_in0 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
--    probe_in1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
--    probe_out0 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
--  );
--END COMPONENT;

--    signal pm_cur: int_array := (0 => 0, others => -1);  
--    signal pm_next: int_array := (others => -1);   
--    signal  sp_next: paths;  
--    signal sp_cur : paths := (others => (others => '0'));
     
--    signal v0, v1: std_logic_vector(0 to 1):= "00";
--    signal s0, s1: std_logic_vector(0 to 1); 
--    signal f: integer := 0;
--    signal fun: std_logic;
--    --signal k: integer := 0;
--    signal j: integer := -1;
    begin
--        st(0) <= "00"; 
--        st(1) <= "01";
--        st(2) <= "10";
--        st(3) <= "11";
        
        comb_proc: process (r)
        variable i: integer;  
        variable pm_cur: int_array := (0 => 0, others => -1); 
        variable pm_next: int_array := (others => -1);
        variable sp_next: paths; 
        variable sp_cur : paths := (others => (others => '0'));
        variable m_next: mpaths;
        variable m_cur : mpaths;
        variable v0, v1: std_logic_vector(0 to 1):= "00";
        variable s0, s1: std_logic_vector(0 to 1); 
        variable ru: integer;
        --variable 
        begin  
            sp_next := (others => (others => '0'));
            sp_cur := (others => (others => '0'));
            pm_cur := (0 => 0, others => -1);    
            pm_next := (others => -1);   
            m_next := (others => (others => '0'));
            m_cur := (others => (others => '0'));
            v0 := "00";
            v1 := "00";
            s0 := "00";
            s1 := "11";
            ru := 0;    
            i := 0;
            while (i < s-1) loop
                pm_next := (others => -1);
                sp_next := (others => (others => '0'));
                m_next := (others => (others => '0'));
                for k in 0 to s-1 loop 
                    if (pm_cur(k) = -1) then next; 
                    end if; 
                    
                    v0(0) := '0'; -- for RSCE
                    v0(1) := st(k)(0);
                    v1(0) := '1';
                    v1(1) := '1' xor st(k)(0);
                    s0(0) := st(k)(0) xor st(k)(1);
                    s0(1) := st(k)(0);
                    s1(0) := '1' xor st(k)(0) xor st(k)(1);
                    s1(1) := st(k)(0);
--                    v0(0) := st(k)(1); -- for a normal encoder
--                    v0(1) := st(k)(1) xor st(k)(0);
                    
--                    v1(0) := '1' xor st(k)(1);
--                    v1(1) := '1' xor st(k)(1) xor st(k)(0);
--                    s0(0) := '0';
--                    s0(1) := st(k)(0);
--                    s1(0) := '1';
--                    s1(1) := st(k)(0);
                    sp_next(to_integer(unsigned(s0))) := sp_cur(k); 
                    sp_next(TO_INTEGER(unsigned(s0)))(i to i+1) := v0; 
                    m_next(to_integer(unsigned(s0))) := m_cur(k); 
                    m_next(TO_INTEGER(unsigned(s0)))(i/2) := '0'; 
                     
                    sp_next(to_integer(unsigned(s1))) := sp_cur(k);
                    sp_next(to_integer(unsigned(s1)))(i to i+1) := v1;
                    m_next(to_integer(unsigned(s1))) := m_cur(k); 
                    m_next(TO_INTEGER(unsigned(s1)))(i/2) := '1'; 
                    
                    pm_next(to_integer(unsigned(s0))) := pm_cur(k);
                    if (v0(0) /= r(i)) then
                        pm_next(to_integer(unsigned(s0))) := pm_next(to_integer(unsigned(s0))) + 1;
                    end if;
                    if (v0(1) /= r(i+1)) then
                        pm_next(to_integer(unsigned(s0))) := pm_next(to_integer(unsigned(s0))) + 1;
                    end if;
                    pm_next(to_integer(unsigned(s1))) := pm_cur(k);
                    if (v1(0) /= r(i)) then
                        pm_next(to_integer(unsigned(s1))) := pm_next(to_integer(unsigned(s1))) + 1;
                    end if;
                    if (v1(1) /= r(i+1)) then
                        pm_next(to_integer(unsigned(s1))) := pm_next(to_integer(unsigned(s1))) + 1;
                    end if;
                    --pm_next(to_integer(unsigned(s1))) := (pm_cur(k) + to_integer(unsigned(v1 xor r(i to i+1))));                                             
                end loop;
                pm_cur := pm_next;
                sp_cur := sp_next;
                m_cur := m_next;
                i := i+2;
            end loop;
            
            while (i >= s and i < rs-s-1) loop
                pm_next := (others => -1);
                sp_next := (others => (others => '0'));
                m_next := (others => (others => '0'));
                for k in 0 to s-1 loop 
                      v0(0) := '0'; -- for RSCE
                        v0(1) := st(k)(0);
                        v1(0) := '1';
                        v1(1) := '1' xor st(k)(0);
                        s0(0) := st(k)(0) xor st(k)(1);
                        s0(1) := st(k)(0);
                        s1(0) := '1' xor st(k)(0) xor st(k)(1);
                        s1(1) := st(k)(0);
--                    v0(0) := st(k)(1); -- for normal encoder
--                    v0(1) := st(k)(1) xor st(k)(0);
--                    v1(0) := '1' xor st(k)(1);
--                    v1(1) := '1' xor st(k)(1) xor st(k)(0);
--                    --s0 <= (0 => '0', 1 => st(k)(0)); 
--                    s0(0) := '0';
--                    s0(1) := st(k)(0);
--                    s1(0) := '1';
--                    s1(1) := st(k)(0);
                    
                    if (pm_next(TO_INTEGER(unsigned(s0))) = -1) then
                        --pm_next(TO_INTEGER(unsigned(s0))) := (pm_cur(k) + to_integer(unsigned(v0 xor r(i to i+1))));
                        pm_next(to_integer(unsigned(s0))) := pm_cur(k);
                        if (v0(0) /= r(i)) then
                            pm_next(to_integer(unsigned(s0))) := pm_next(to_integer(unsigned(s0))) + 1;
                        end if;
                        if (v0(1) /= r(i+1)) then
                            pm_next(to_integer(unsigned(s0))) := pm_next(to_integer(unsigned(s0))) + 1;
                        end if;
                    
                        sp_next(to_integer(unsigned(s0))) := sp_cur(k);
                        sp_next(TO_INTEGER(unsigned(s0)))(i to i+1) := v0; 
                        m_next(to_integer(unsigned(s0))) := m_cur(k); 
                        m_next(TO_INTEGER(unsigned(s0)))(i/2) := '0'; 
                    else
                        ru := pm_cur(k);
                        if (v0(0) /= r(i)) then
                            ru := ru + 1;
                        end if;
                        if (v0(1) /= r(i+1)) then
                            ru := ru + 1;
                        end if; 
                        if (pm_next(TO_INTEGER(unsigned(s0))) > (ru)) then
                            --pm_next(TO_INTEGER(unsigned(s0))) := (pm_cur(k) + to_integer(unsigned(v0 xor r(i to i+1))));
                            pm_next(to_integer(unsigned(s0))) := ru;
                                                
                            sp_next(to_integer(unsigned(s0))) := sp_cur(k);
                            sp_next(TO_INTEGER(unsigned(s0)))(i to i+1) := v0; 
                            m_next(to_integer(unsigned(s0))) := m_cur(k); 
                            m_next(TO_INTEGER(unsigned(s0)))(i/2) := '0';
                        end if;
                    end if;
                    if (pm_next(TO_INTEGER(unsigned(s1))) = -1) then
                        --pm_next(TO_INTEGER(unsigned(s1))) := (pm_cur(k) + to_integer(unsigned(v1 xor r(i to i+1))));
                        pm_next(to_integer(unsigned(s1))) := pm_cur(k);
                        if (v1(0) /= r(i)) then
                            pm_next(to_integer(unsigned(s1))) := pm_next(to_integer(unsigned(s1))) + 1;
                        end if;
                        if (v1(1) /= r(i+1)) then
                            pm_next(to_integer(unsigned(s1))) := pm_next(to_integer(unsigned(s1))) + 1;
                        end if;
                        sp_next(to_integer(unsigned(s1))) := sp_cur(k);
                        sp_next(TO_INTEGER(unsigned(s1)))(i to i+1) := v1; 
                        m_next(to_integer(unsigned(s1))) := m_cur(k); 
                        m_next(TO_INTEGER(unsigned(s1)))(i/2) := '1';
                    else 
                        ru := pm_cur(k);
                        if (v1(0) /= r(i)) then
                            ru := ru + 1;
                        end if;
                        if (v1(1) /= r(i+1)) then
                            ru := ru + 1;
                        end if; 
                        if (pm_next(TO_INTEGER(unsigned(s1))) > (ru)) then
                            --pm_next(TO_INTEGER(unsigned(s1))) := (pm_cur(k) + to_integer(unsigned(v1 xor r(i to i+1))));
                            pm_next(to_integer(unsigned(s1))) := ru;
                            
                            sp_next(to_integer(unsigned(s1))) := sp_cur(k);
                            sp_next(TO_INTEGER(unsigned(s1)))(i to i+1) := v1; 
                            m_next(to_integer(unsigned(s1))) := m_cur(k); 
                            m_next(TO_INTEGER(unsigned(s1)))(i/2) := '1';
                        end if;
                    end if;                    
                end loop;
                pm_cur := pm_next;
                sp_cur := sp_next;
                m_cur := m_next;
                i := i+2;
            end loop;
            
            while (i >= rs-s and i < rs) loop
                pm_next := (others => -1);
                sp_next := (others => (others => '0'));
                m_next := (others => (others => '0'));
                for k in 0 to s-1 loop
                    if (pm_cur(k) = -1) then next;                        
                    end if;    
                    v0(0) := '0'; -- for RSCE
                    v0(1) := st(k)(0);
                    
                    s0(0) := st(k)(0) xor st(k)(1);
                    s0(1) := st(k)(0);
                    
--                    v0(0) := st(k)(1); -- for normal encoder
--                    v0(1) := st(k)(1) xor st(k)(0);
                    
--                    s0(0) := '0';
--                    s0(1) := st(k)(0);
                                        
                    if (pm_next(TO_INTEGER(unsigned(s0))) = -1) then
                        --pm_next(TO_INTEGER(unsigned(s0))) := (pm_cur(k) + to_integer(unsigned(v0 xor r(i to i+1))));
                        pm_next(to_integer(unsigned(s0))) := pm_cur(k);
                        if (v0(0) /= r(i)) then
                            pm_next(to_integer(unsigned(s0))) := pm_next(to_integer(unsigned(s0))) + 1;
                        end if;
                        if (v0(1) /= r(i+1)) then
                            pm_next(to_integer(unsigned(s0))) := pm_next(to_integer(unsigned(s0))) + 1;
                        end if;
                    
                        sp_next(to_integer(unsigned(s0))) := sp_cur(k);
                        sp_next(TO_INTEGER(unsigned(s0)))(i to i+1) := v0; 
                        m_next(to_integer(unsigned(s0))) := m_cur(k); 
                        m_next(TO_INTEGER(unsigned(s0)))(i/2) := '0';
                    else 
                        ru := pm_cur(k);
                        if (v0(0) /= r(i)) then
                            ru := ru + 1;
                        end if;
                        if (v0(1) /= r(i+1)) then
                            ru := ru + 1;
                        end if; 
                        if (pm_next(TO_INTEGER(unsigned(s0))) > (ru)) then
                            --pm_next(TO_INTEGER(unsigned(s0))) := (pm_cur(k) + to_integer(unsigned(v0 xor r(i to i+1))));
                            pm_next(to_integer(unsigned(s0))) := ru;
                            
                    
                            sp_next(to_integer(unsigned(s0))) := sp_cur(k);
                            sp_next(TO_INTEGER(unsigned(s0)))(i to i+1) := v0; 
                            m_next(to_integer(unsigned(s0))) := m_cur(k); 
                            m_next(TO_INTEGER(unsigned(s0)))(i/2) := '0';
                        end if;
                    end if;
                    
                end loop;
                pm_cur := pm_next;
                sp_cur := sp_next;
                m_cur := m_next;
                i := i+2;
            end loop; 
            v <= sp_cur(0);
            u <= m_cur(0);
        end process comb_proc;  
        
--        your_instance_name : vio_3
--  PORT MAP (
--    clk => clk,
--    probe_in0 => v,
--    probe_in1 => u,
--    probe_out0 => r
--  );
--        clk_proc: process (clk, reset, pm_next, sp_next)  
--            begin  
--                if (reset = '1') then v <= (others => '0');
--                end if;
--                if (falling_edge(clk)) then
                
                    
--                end if;
--        end process clk_proc;
your_instance_name : vio_0
  PORT MAP (
    clk => clk,
    probe_in0 => v,
    probe_in1 => u,
    probe_out0 => r
  );
end arch;
