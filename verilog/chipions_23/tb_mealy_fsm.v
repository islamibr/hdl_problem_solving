module tb_mealy_fsm;
    reg clk, rst, inp;
    wire outp;

    mealy_fsm uut (
        .clk(clk),
        .rst(rst),
        .inp(inp),
        .outp(outp)
    );

    initial begin
        // Initialize inputs
        clk = 0;
        rst = 0;
        inp = 0;

        // Apply reset
        rst = 1; #10;
        rst = 0; #10;

        // Apply test sequence: 1101
        inp = 1; #10;
        inp = 1; #10;
        inp = 0; #10;
        inp = 1; #10;

        // Apply test sequence: 1101101
        inp = 1; #10;
        inp = 1; #10;
        inp = 0; #10;
        inp = 1; #10;

        // Finish simulation
        $finish;
    end

    always #5 clk = ~clk;  // Clock generation
endmodule
