# Simple-RV32I-core-in-VHDL
My first VHDL project, if you have any questions or suggestions you can contact me.<br />

TO BE DONE:<br />
-GDSI file <br />
-Formal verification

```mermaid
graph TD
    subgraph Fetch
        PC[Program Counter] --> IM[Instruction Memory]
    end
    IM --> Decoder[Decoder]
    subgraph Execute
        Decoder --> CU[Control Unit]
        CU --> RF[Register File]
        RF --> ALU[ALU - 314 LUTs]
    end
    ALU --> RAM[Data RAM]
    RAM --> WB[Write-Back]
    WB --> RF
