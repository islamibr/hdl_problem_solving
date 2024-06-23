module mealy_fsm(
    input wire clk,
    input wire rst,
    input wire inp,
    output reg outp
);

    // State encoding
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;
    localparam S3 = 2'b11;

    reg [1:0] state, next_state;

    // State Transition
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= S0;
        else
            state <= next_state;
    end

    // Next State Logic and Output Logic
    always @(*) begin
        case (state)
            S0: begin
                next_state = (inp) ? S1 : S0;
                outp = 0;
            end
            S1: begin
                next_state = (inp) ? S2 : S0;
                outp = 0;
            end
            S2: begin
                next_state = (inp) ? S2 : S3;
                outp = 0;
            end
            S3: begin
                next_state = (inp) ? S0 : S0;
                outp = (inp) ? 1 : 0;
            end
            default: begin
                next_state = S0;
                outp = 0;
            end
        endcase
    end

endmodule
