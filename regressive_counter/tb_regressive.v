`timescale 1ns / 1ps

module tb_regressive;
    reg clock;
    reg reset;
    reg [3:0] seconds_period;
    reg start;

    wire [6:0] hex5_seconds_left;
    wire ledr9_finished;

    regressive_counter uut (
        .clock(clock), 
        .reset(reset), 
        .seconds_period(seconds_period), 
        .start(start), 
        .hex5_seconds_left(hex5_seconds_left), 
        .ledr9_finished(ledr9_finished)
    );

    always #10 clock = ~clock;

    initial begin
        $dumpfile("ondas.vcd");
        $dumpvars(0, tb_regressive);

        // Estado Inicial
        clock = 0;
        reset = 1;
        start = 0;
        seconds_period = 4'd5; // 5 segundos

        // Espera um pouco e solta o reset
        #20 reset = 0;

        // Inicia a contagem
        #20 start = 1;

        // Roda por tempo suficiente para ver a contagem chegar a 0 e reiniciar
        #600;

        // Teste de Pause
        start = 0;
        #100;
        start = 1;
        #200;

        $finish;
    end
endmodule