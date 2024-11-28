module spi_master (
    input wire clk,
    input wire reset,
    input wire [7:0] data_in,
    input wire start,
    output reg mosi,
    input wire miso,
    output reg sclk,
    output reg cs,
    output reg [7:0] data_out,
    output reg done
);
    reg [2:0] bit_cnt;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            mosi <= 1'b0;
            sclk <= 1'b0;
            cs <= 1'b1;
            bit_cnt <= 0;
            done <= 0;
        end else if (start) begin
            cs <= 0;
            sclk <= ~sclk;
            if (sclk) begin // Rising edge of sclk
                mosi <= data_in[7 - bit_cnt];
                data_out <= {data_out[6:0], miso};
                bit_cnt <= bit_cnt + 1;
                if (bit_cnt == 7) begin
                    done <= 1;
                    cs <= 1;
                end
            end
        end else begin
            done <= 0;
        end
    end
endmodule

