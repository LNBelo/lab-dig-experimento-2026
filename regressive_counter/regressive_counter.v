// Antes do start hex5_seconds_left deve mostrar seconds_period

module regressive_counter (
    input clock,
    input reset,
    input [3:0] seconds_period, // define o período de tempo
    input start,
    output [6:0] hex5_seconds_left, // mostrar qunato tempo falta
    output reg ledr9_finished
);

    reg [3:0] valor_atual;
    wire pulso_de_1s;

    one_second_counter contador (
        .clock(clock),
        .reset(reset),
        .start(start), // O contador de tempo só anda se start estiver alto
        .finished(pulso_de_1s)
    );

    hexa7seg display (
        .hexa(contagem_atual),
        .sseg(hex5_seconds_left)
    );

    always @(posedge clock) begin
        if (reset) begin
            contagem_atual <= seconds_period;
            ledr9_finished <= 1'b0;
        end 
        else if (start) begin
            if (pulso_de_1s) begin
                if (contagem_atual == 0) begin
                    contagem_atual <= seconds_period;
                    ledr9_finished <= 1'b0;
                end else begin
                    contagem_atual <= contagem_atual - 1;
                end
            end
            if (contagem_atual == 0) 
                ledr9_finished <= 1'b1;
            else 
                ledr9_finished <= 1'b0;  
        end
    end

endmodule