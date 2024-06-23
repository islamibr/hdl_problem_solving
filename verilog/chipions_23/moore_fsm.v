module moore_fsm(
    input wire clk,
    input wire rst,
    input wire inp,
    output reg outp
);

    // State encoding
    localparam S0 = 3'b000;
    localparam S1 = 3'b001;
    localparam S2 = 3'b010;
    localparam S3 = 3'b011;
    localparam S4 = 3'b100;

    reg [2:0] state, next_state;

    // State Transition
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= S0;
        else
            state <= next_state;
    end

    // Next State Logic
    always @(*) begin
        case (state)
            S0: next_state = (inp) ? S1 : S0;
            S1: next_state = (inp) ? S2 : S0;
            S2: next_state = (inp) ? S2 : S3;
            S3: next_state = (inp) ? S4 : S0;
            S4: next_state = (inp) ? S1 : S0;
            default: next_state = S0;
        endcase
    end

    // Output Logic
    always @(*) begin
        case (state)
            S0: outp = 0;
            S1: outp = 0;
            S2: outp = 0;
            S3: outp = 0;
            S4: outp = 1;
            default: outp = 0;
        endcase
    end

endmodule
