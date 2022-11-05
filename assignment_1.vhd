----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.10.2022 17:42:52
-- Design Name: 
-- Module Name: assignment_1 - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity assignment_1 is
    Port ( H : in STD_LOGIC_VECTOR(15 downto 0);
           clk : in STD_LOGIC;
           A : out STD_LOGIC;
           B : out STD_LOGIC;
           C : out STD_LOGIC;
           D : out STD_LOGIC;
           E : out STD_LOGIC;
           F : out STD_LOGIC;
           G : out STD_LOGIC;
           w : out STD_LOGIC;
           x : out STD_LOGIC;
           y : out STD_LOGIC;
           z : out STD_LOGIC);
end assignment_1;

architecture Behavioral of assignment_1 is 
signal p:std_logic_vector(3 downto 0):="0000";
signal reset : integer range 0 to 1048576:=0;
signal refresh_counter : std_logic_vector(19 downto 0);
signal anode_activate: std_logic_vector(1 downto 0):="00";
begin
process(p)
begin 
A <= ((not p(3)) and (not p(2)) and (not p(1)) and p(0)) or ((not p(3)) and p(2) and (not p(1)) and (not p(0))) or (p(3) and p(2) and (not p(1)) and p(0))
or (p(3) and (not p(2)) and p(1) and p(0));
B <= (p(2) and p(1) and (not p(0))) or (p(3) and p(1) and p(0)) or ((not p(3)) and p(2) and (not p(1)) and p(0)) or (p(3) and p(2) and (not p(1)) and (not p(0)));
C <= ((not p(3)) and (not p(2)) and p(1) and (not p(0))) or (p(3) and p(2) and p(1)) or (p(3) and p(2) and (not p(0)));
D <= ((not p(3)) and (not p(2)) and (not p(1)) and p(0)) or ((not p(3)) and p(2) and (not p(1)) and (not p(0))) or (p(3) and (not p(2)) and p(1) and (not p(0))) 
or (p(2) and p(1) and p(0));
E <= ((not p(2)) and (not p(1)) and p(0)) or ((not p(3)) and p(0)) or ((not p(3)) and p(2) and (not p(1)));
F <= ((not p(3)) and (not p(2)) and p(0)) or ((not p(3)) and (not p(2)) and p(1)) or ((not p(3)) and p(1) and p(0)) or (p(3) and p(2) and (not p(1)) and p(0));
G <= ((not p(3)) and (not p(2)) and (not p(1))) or ((not p(3)) and p(2) and p(1) and p(0)) or (p(3) and p(2) and (not p(1)) and (not p(0)));
end process;
process(clk)
begin
if(rising_edge(clk)) then
    refresh_counter <= refresh_counter+'1';
    reset <= reset + 1;
    if reset = 1048576 then
        reset <= 0;
        refresh_counter <= (others => '0');
    end if;
end if;
end process;
anode_activate <= refresh_counter(19 downto 18);
process(anode_activate)
begin
    case anode_activate is
        when "00" => 
            w <= '0';
            x <= '1';
            y <= '1';
            z <= '1';
            p <= H(15 downto 12);
        when "01" => 
            w <= '1';
            x <= '0';
            y <= '1';
            z <= '1';
            p <= H(11 downto 8);
        when "10" => 
            w <= '1';
            x <= '1';
            y <= '0';
            z <= '1';
            p <= H(7 downto 4);
        when "11" => 
            w <= '1';
            x <= '1';
            y <= '1';
            z <= '0';
            p <= H(3 downto 0);
        when others => 
            w <= '1';
            x <= '1';
            y <= '1';
            z <= '1';
    end case;
end process;
end Behavioral;