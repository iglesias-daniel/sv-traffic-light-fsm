`timescale 1s / 1s

module traffic_light_tb;

    logic clk, rst_n, en;
    logic red, yellow, green;

    traffic_light dut (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .red(red),
        .yellow(yellow),
        .green(green)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("build/traffic_light_tb.vcd");
        $dumpvars(0,traffic_light_tb);
        $display("Simulation begins");
        $monitor("t=%0t | red=%b yellow=%b green=%b", $time, red, yellow, green);
        rst_n = 0;
        en = 0;
        #15 rst_n = 1;
        #15 en = 1;
        #300;
        $finish;
    end
endmodule