module spi_top (
    input wire clk,
    input wire reset,
    input wire [7:0] master_data_in,
    input wire start,
    input wire slave_data_in,
    output wire miso,
    output wire mosi,
    output wire sclk,
    output wire cs,
    output wire [7:0] master_data_out,
    output wire done
);
    spi_master master (
        .clk(clk),
        .reset(reset),
        .data_in(master_data_in),
        .start(start),
        .mosi(mosi),
        .miso(miso),
        .sclk(sclk),
        .cs(cs),
        .data_out(master_data_out),
        .done(done)
    );

    spi_slave slave (
        .clk(clk),
        .reset(reset),
        .mosi(mosi),
        .sclk(sclk),
        .cs(cs),
        .miso(miso),
        .data_out(),
        .data_in(slave_data_in)
    );
endmodule

