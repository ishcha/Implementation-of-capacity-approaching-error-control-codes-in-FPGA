----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.12.2020 21:30:50
-- Design Name: 
-- Module Name: interleaver_tb - tb_Arch
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_textio.all;
use std.textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity interleaver_tb is
--  Port ( );
end interleaver_tb;

architecture tb_Arch of interleaver_tb is
    component interleaver 
    generic(
        s : integer := 2;
        m : integer := 16
    );
    Port (
        u : in std_logic_vector(0 to m-1);
        w : out std_logic_vector(0 to m-1)
        --clk: in std_logic
    );
    end component interleaver;
    
    constant m_tb: integer := 16;
    constant s_tb: integer := 2;
    signal u_tb: std_logic_vector(0 to m_tb-1);
    signal w_tb: std_logic_vector(0 to m_tb-1);
    signal expect: std_logic_vector(0 to m_tb-1);
    
begin
    -- DUT instantiation
    DUT: interleaver generic map
    (
        s => s_tb,
        m => m_tb    
    )
    port map(
        u => u_tb,
        w => w_tb
    );
    
    -- stimulus by hand-drawn waves: poor coverage => no way apart from the code to get to the right result
    
    stim_proc: process
    begin 
        wait for 0ns;
            u_tb <= "0010110000100011";
            expect <= "0000110010100101";
        wait;    
    end process stim_proc;
    
    -- text-based monitoring
    txt_out: process(w_tb) 
        variable str_o: line;
    begin
        write(str_o, string'("u = "));
        write(str_o, u_tb);
        write(str_o, string'("w = "));
        write(str_o, w_tb);
        write(str_o, string'("expect = "));
        write(str_o, expect);
        assert false report time'image(now) & str_o.all severity note; 
    end process txt_out;    
end tb_Arch;
