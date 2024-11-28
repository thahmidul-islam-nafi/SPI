module spi_slave (
    input wire clk,
    input wire reset,
    input wire mosi,
    input wire sclk,
    input wire cs,
    output reg miso,
    output reg [7:0] data_out,
    input wire [7:0] data_in
);
    reg [2:0] bit_cnt;

    always @(posedge sclk or posedge reset) begin
        if (reset) begin
            bit_cnt <= 0;
            miso <= 1'b0;
            data_out <= 8'b0;
        end else if (!cs) begin
            data_out <= {data_out[6:0], mosi}; // Shift in MOSI data
            miso <= data_in[7 - bit_cnt]; // Shift out MISO data
            bit_cnt <= bit_cnt + 1;
        end
    end
endmodule

