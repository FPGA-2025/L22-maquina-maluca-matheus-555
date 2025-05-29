`timescale 1ns/1ps

module tb();

localparam QTDE_LINHAS_TESTE = 68;
localparam QTDE_BITS_TESTE   = 6;

reg clk = 0;
reg rst_n;
reg start;
wire [3:0] state;

integer i;
reg [QTDE_BITS_TESTE-1:0] dados_arquivo [0:QTDE_LINHAS_TESTE-1];
reg [3:0] state_txt;

maquina_maluca dut (
    .clk   (clk),
    .rst_n (rst_n),
    .start (start),
    .state (state)
);

always #1 clk = ~clk;

initial begin
    // Insira o seu teste aqui
    $readmemb("teste.txt", dados_arquivo);
    $dumpfile("saida.vcd");
    $dumpvars(0, tb);

    for(i = 0; i < QTDE_LINHAS_TESTE; i = i+1) begin
        state_txt = dados_arquivo[i][3:0];
        start     = dados_arquivo[i][4];
        rst_n     = dados_arquivo[i][5];
        #2;

        if (state_txt == state)
            $display("rst_n=%d start=%d state=%d (OK)", rst_n, start, state);
        else
            $display("rst_n=%d start=%d expected_state=%d current_state=%d (ERRO)", rst_n, start, state_txt, state);
    end

    $finish;
end

endmodule
