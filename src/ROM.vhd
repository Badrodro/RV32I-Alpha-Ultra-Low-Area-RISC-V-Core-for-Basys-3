library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ROM is
    Port (
    instrIN: in std_logic_vector(31 downto 0); -- instruction coming from the program counter
    
    instrOUT: out std_logic_vector(31 downto 0) -- instruction stocked in the ROM
    
    
    
     );
end ROM;

architecture Behavioral of ROM is
type rom_type is array(0 to 63) of std_logic_vector(31 downto 0);
signal s_rom : rom_type := (
   -- torture program
0 => x"123450b7", -- LUI x1, 0x12345      (Force MSB )
1 => x"67808093", -- ADDI x1, x1, 0x678   (Imm_gen on 12 bits)
2 => x"00102223", -- SW x1, 4(x0)         (Write RAM)
3 => x"00402103", -- LW x2, 4(x0)         (Read  RAM)
4 => x"401101b3", -- SUB x3, x2, x1       (SUB)
5 => x"00018463", -- BEQ x3, x0, 8        (Branch eq)
6 => x"0080026f", -- JAL x4, 8            (Jump)
7 => x"00118193", -- ADDI x3, x3, 1       (ADD imm)
8 => x"00302423", -- SW x3, 8(x0)         (Store value)
others => x"00000013" -- NOP
);

begin


instrOUT <= s_rom(to_integer(unsigned(instrIN(7 downto 2)))); -- we divide by 4 (ignore 2 last bits) because the PC increase by 4 octets and we slice at the bit 7 downto 2 because we need only 6 bits to access all of our ROM

end Behavioral;
