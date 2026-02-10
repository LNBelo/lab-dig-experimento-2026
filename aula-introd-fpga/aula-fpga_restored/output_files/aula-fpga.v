module full_adder (
    input wire a,
    input wire b,
    input wire cin,
    output wire sum,
    output wire cout
);

    assign sum = a ^ b ^ cin;
    assign cout = (a & cin) | (a & b) | (b & cin);

endmodule

module full_adder_4bit (
    input wire cin,
    input wire [3:0] a,
    input wire [3:0] b,
    output wire [3:0] sum,
    output wire cout
);

    // carries intermediários
    wire c_temp_0, c_temp_1, c_temp_2;

    // Instanciação do full adder de 1 bit para o Bit 0 (LSB)
    full_adder fa0 (
        .a(a[0]), 
        .b(b[0]), 
        .cin(cin), 
        .sum(sum[0]), 
        .cout(c_temp_0)
    );

    // Bit 1
    full_adder fa1 (
        .a(a[1]), 
        .b(b[1]), 
        .cin(c_temp_0), 
        .sum(sum[1]), 
        .cout(c_temp_1)
    );

    // Bit 2
    full_adder fa2 (
        .a(a[2]), 
        .b(b[2]), 
        .cin(c_temp_1), 
        .sum(sum[2]), 
        .cout(c_temp_2)
    );

    // Bit 3 (MSB)
    full_adder fa3 (
        .a(a[3]), 
        .b(b[3]), 
        .cin(c_temp_2), 
        .sum(sum[3]), 
        .cout(cout)
    );

endmodule