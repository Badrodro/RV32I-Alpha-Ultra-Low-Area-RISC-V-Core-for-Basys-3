library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Un testbench n'a pas de ports (c'est une entité vide)
entity top_tb is
end top_tb;

architecture sim of top_tb is
    -- 1. Signaux mis à jour
    signal clk_tb     : std_logic := '0';
    signal reset_tb   : std_logic := '1';
    signal trap_tb    : std_logic; -- NOUVEAU : Signal pour surveiller le trap
    signal testOUT_tb : std_logic_vector(31 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- 3. Instanciation mise à jour (Port Map complet)
    uut: entity work.top
        port map (
            clk     => clk_tb,
            reset   => reset_tb,
            trap    => trap_tb, -- LIAISON DU PORT TRAP
            testOUT => testOUT_tb
        );

    -- 4. Horloge (inchangée)
    clk_process : process
    begin
        clk_tb <= '0'; wait for clk_period/2;
        clk_tb <= '1'; wait for clk_period/2;
    end process;

    -- 5. Scénario de test intelligent
    stim_proc: process
    begin        
        reset_tb <= '1';
        wait for 25 ns;
        reset_tb <= '0';

        -- Au lieu de wait for 1000ns, on attend l'événement système
        -- C'est beaucoup plus pro pour ton dossier de recherche
        wait until trap_tb = '1' for 2000 ns; 

        if trap_tb = '1' then
            assert false report "SUCCES : Instruction SYSTEM détectée. Fin propre du programme." severity note;
        else
            assert false report "ERREUR : Time-out ! Le processeur n'a jamais levé le signal TRAP." severity failure;
        end if;

        wait;
    end process;

end sim;