module moduleName #(
    parameter CYCLE_RED = 5,
    parameter CYCLE_RED_YELLOW = 2,
    parameter CYCLE_GREEN = 5,
    parameter CYCLE_YELLOW = 2,
    parameter TIME_WIDTH = 3
) (
    input clk, rst_n, en,
    output logic red, yellow, green
);

    logic [TIME_WIDTH-1:0] time_next_state;

    typedef enum logic [1:0] { 
        STOP,
        WAIT,
        GO,
        CAUTION
    } state_t;
    
    state_t state, next_state;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= STOP;
            time_next_state <= CYCLE_RED;
        end else begin
            if (en) begin
                if (state != next_state) begin
                    case (next_state)
                        STOP: time_next_state <= CYCLE_RED;
                        WAIT: time_next_state <= CYCLE_RED_YELLOW;
                        GO: time_next_state <= CYCLE_GREEN;
                        CAUTION: time_next_state <= CYCLE_YELLOW;
                        default: time_next_state <= 0;
                    endcase
                end else begin
                    time_next_state <= time_next_state - 1;
                end
                state <= next_state;
            end
        end
        
    end

    always_comb begin
        next_state = state;
        case (state)
            STOP:
                if (time_next_state == 0)
                    next_state = WAIT;
            WAIT:
                if (time_next_state == 0)
                    next_state = GO;
            GO:
                if (time_next_state == 0)
                    next_state = CAUTION;
            CAUTION:
                if (time_next_state == 0)
                    next_state = STOP;
            default: next_state = STOP;
        endcase
    end

    always_comb begin
        case (state)
            STOP: begin
                red = 1;
                yellow = 0;
                green = 0;
            end
            WAIT: begin
                red = 1;
                yellow = 1;
                green = 0;
            end
            GO: begin
                red = 0;
                yellow = 0;
                green = 1;
            end
            CAUTION: begin
                red = 0;
                yellow = 1;
                green = 0;
            end
            default: begin
                red = 0;
                yellow = 0;
                green = 0;
            end
        endcase
    end

endmodule