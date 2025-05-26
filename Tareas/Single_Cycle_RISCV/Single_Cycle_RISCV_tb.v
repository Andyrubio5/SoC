`timescale 1ps/1ps

module Single_cycle_RISCV_tb;
    reg clk;
    reg reset;
    wire [31:0] instruction;
    wire [31:0] pc_out;
    wire [31:0] alu_result;
    wire [31:0] data_out;

    // Debug signals - declare as wires
    wire MemWrite;
    wire [31:0] Address;
    wire [31:0] WriteData;
    wire [31:0] DataAddr;

    // Instantiate the Single Cycle RISC-V processor with debug outputs
    Single_cycle_RISCV uut (
        .clk(clk),
        .pc_out(pc_out),
        .alu_result(alu_result),
        .MemWrite(MemWrite),
        .Address(Address),
        .WriteData(WriteData),
        .DataAddr(DataAddr)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // 10ps period (5ps high, 5ps low)
    end

    // Testbench stimulus
    initial begin
        // Initialize Inputs
        clk = 0;
        
        // Monitor important signals including debug signals
        $monitor("Time=%0t PC=%h ALU=%h MemWrite=%b Addr=%h WriteData=%h", 
                 $time, pc_out, alu_result, MemWrite, Address, WriteData);
        
        // Run simulation
        #100;  // Run for 100 time units
        
        $finish;
    end

    // Memory write test - now using declared signals
    always @(posedge clk) begin
        if(MemWrite) begin
            if(Address == 100 && WriteData == 25) begin
                $display("PASSED: Data 25 written to address 100");
                $stop;
            end else if (DataAddr != 96) begin
                $display("FAILED: Incorrect memory access - Expected DataAddr=96, got %d", DataAddr);
                $stop;
            end
        end
    end

endmodule