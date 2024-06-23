module alu_tb;
    reg [7:0] A, B;
    reg [2:0] opCode;
    wire [7:0] Out;
    wire Carry_out, C_flag;
    
    // Instantiate the ALU module
    alu uut (
        .A(A),
        .B(B),
        .opCode(opCode),
        .Out(Out),
        .Carry_out(Carry_out),
        .C_flag(C_flag)
    );

    // Task to display results
    task display_results;
        begin
            $display("A = %b, B = %b, opCode = %b, Out = %b, Carry_out = %b, C_flag = %b", A, B, opCode, Out, Carry_out, C_flag);
        end
    endtask

    initial begin
        // Initialize inputs
        A = 8'b00000000;
        B = 8'b00000000;
        opCode = 3'b000;
        
        // Test ADD
        A = 8'b00001101; B = 8'b00000110; opCode = 3'b000; #10; display_results(); // ADD
        A = 8'b11111111; B = 8'b00000001; opCode = 3'b000; #10; display_results(); // ADD with carry

        // Test SUB
        A = 8'b00001101; B = 8'b00000110; opCode = 3'b001; #10; display_results(); // SUB
        A = 8'b00000001; B = 8'b00000010; opCode = 3'b001; #10; display_results(); // SUB with borrow
        
        // Test AND
        A = 8'b00001101; B = 8'b00000110; opCode = 3'b010; #10; display_results(); // AND

        // Test OR
        A = 8'b00001101; B = 8'b00000110; opCode = 3'b011; #10; display_results(); // OR
        
        // Test XOR
        A = 8'b00001101; B = 8'b00000110; opCode = 3'b100; #10; display_results(); // XOR
        
        // Test Comparison
        A = 8'b00001101; B = 8'b00000110; opCode = 3'b101; #10; display_results(); // Comparison A > B
        A = 8'b00000110; B = 8'b00001101; opCode = 3'b101; #10; display_results(); // Comparison A < B

        // Test Shift Left A
        A = 8'b00001101; opCode = 3'b110; #10; display_results(); // Shift A left
        
        // Test Shift Left B
        B = 8'b00000110; opCode = 3'b111; #10; display_results(); // Shift B left

        $finish;
    end
endmodule
