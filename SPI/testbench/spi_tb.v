`timescale 1ns / 1ps

module spi_tb;

    // Testbench Signals
    reg clk;
    reg reset;
    reg [7:0] master_data_in;
    reg start;
    reg [7:0] slave_data_in;
    wire miso;
    wire mosi;
    wire sclk;
    wire cs;
    wire [7:0] master_data_out;
    wire done;

    // Instantiate the SPI Top Module
    spi_top uut (
        .clk(clk),
        .reset(reset),
        .master_data_in(master_data_in),
        .start(start),
        .slave_data_in(slave_data_in),
        .miso(miso),
        .mosi(mosi),
        .sclk(sclk),
        .cs(cs),
        .master_data_out(master_data_out),
        .done(done)
    );

    // Clock Generation
    initial clk = 0;
    always #5 clk = ~clk;

    // Test Procedure
    initial begin
        // Initialize signals
        reset = 1;
        master_data_in = 8'h00;
        start = 0;
        slave_data_in = 8'hF0;

        // Reset the system
        #20;
        reset = 0;

        // Start SPI transaction
        master_data_in = 8'hA5; // Example data
        start = 1;
        #10;
        start = 0;

        // Wait for the transaction to complete
        #200;

        // Observe the results
        $display("Master Sent: %h", master_data_in);
        $display("Master Received: %h", master_data_out);

        // End simulation
        $stop;
    end
endmodule

