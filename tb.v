`timescale 1ns / 1ps

module tb(

    );
    reg clk_100MHz_tb,sw_red_tb,sw_green_tb,sw_blue_tb,sw_up_tb,sw_down_tb,sw_left_tb,sw_right_tb,
    cursor_size_tb,eraaser_tb,reset_tb,draw_layer1_en_tb,draw_layer2_en_tb,draw_layer3_en_tb,show_layer_1_tb,show_layer_2_tb,
    show_layer_3_tb,record_rect_pt_tb,draw_rectangle_tb,control_speed_cursor_tb;
    
    
    wire hsync_tb,vsync_tb;
    wire[2:0] rgb_tb;
    wire[1:0] rect_state_led_tb;
    
    ELEC4320_VGA tb(
        .clk_100MHz(clk_100MHz_tb),      // from FPGA
        .sw_red(sw_red_tb),          // 1 bit for red color
        .sw_green(sw_green_tb),        // 1 bit for green color
        .sw_blue(sw_blue_tb),         // 1 bit for blue color
        .sw_up(sw_up_tb),           // switch to move cursor up
        .sw_down(sw_down_tb),         // switch to move cursor down
        .sw_left(sw_left_tb),         // switch to move cursor left
        .sw_right(sw_right_tb),        // switch to move cursor right
        .sw_size(cursor_size_tb),
        .eraser(eraaser_tb),
        .reset(reset_tb),
        .draw_layer1_en(draw_layer1_en_tb),
        .draw_layer2_en(draw_layer2_en_tb),
        .draw_layer3_en(draw_layer3_en_tb),
        .show_layer_1(show_layer_1_tb),
        .show_layer_2(show_layer_2_tb),
        .show_layer_3(show_layer_3_tb),
        .record_rect_pt(record_rect_pt_tb),
        .draw_rectangle(draw_rectangle_tb),
        .control_speed_cursor(control_speed_cursor_tb),
        .hsync(hsync_tb), 
        .vsync(vsync_tb),
        .rgb(rgb_tb),      // 3 FPGA pins for RGB (1 per color)
        .rect_state_led(rect_state_led_tb)
    
    ); 
        initial begin
        clk_100MHz_tb  = 0;
        forever #5 clk_100MHz_tb = !clk_100MHz_tb ; 
        end
        initial begin
        
        sw_red_tb = 1'b0;
        sw_green_tb = 1'b0;
        sw_blue_tb = 1'b0;
        sw_up_tb = 1'b0;
        sw_down_tb = 1'b0;
        sw_left_tb = 1'b0;
        sw_right_tb = 1'b0;
        cursor_size_tb = 1'b0;
        eraaser_tb = 1'b0;
        reset_tb = 1'b0;
        draw_layer1_en_tb = 1'b0;
        draw_layer2_en_tb = 1'b0;
        draw_layer3_en_tb = 1'b0;
        show_layer_1_tb = 1'b0;
        show_layer_2_tb = 1'b0;
        show_layer_3_tb = 1'b0;
        record_rect_pt_tb = 1'b0;
        draw_rectangle_tb = 1'b0;
        control_speed_cursor_tb = 1'b0;
        
        
        //Test no layer show, should all white RGB =3'b111
        #100
        //Test layer 1 drawing
        draw_layer1_en_tb = 1'b1;
        show_layer_1_tb = 1'b1;
        draw_layer1_en_tb = 1'b1;
        sw_blue_tb = 1'b1; 
        #52000000
        //Test layer 2 drawing 
        show_layer_1_tb = 1'b0;
        draw_layer1_en_tb = 1'b0;
        sw_blue_tb = 1'b0;
        show_layer_2_tb = 1'b1;
        draw_layer2_en_tb = 1'b1;
        sw_green_tb = 1'b1; 
        #52000000
        //Test layer 3 drawing 
        show_layer_2_tb = 1'b0;
        draw_layer2_en_tb = 1'b0;
        sw_green_tb = 1'b0;
        show_layer_3_tb = 1'b1;
        draw_layer3_en_tb = 1'b1;
        sw_red_tb = 1'b1; 
        #52000000
        //After tested each layer and color write to memory
        //Test cursor movement
        sw_up_tb = 1'b1;
        sw_right_tb = 1'b1; 
        #52000000
        sw_up_tb = 1'b0;
        sw_right_tb = 1'b0; 
        sw_red_tb = 1'b1;
        sw_green_tb = 1'b1;     
        sw_down_tb = 1'b1;
        sw_left_tb = 1'b1;
        #40000000
        //Test cursor speed, enable is faster 4x 
        control_speed_cursor_tb = 1'b1;
        record_rect_pt_tb = 1'b1; //record first point
        #60000000
        record_rect_pt_tb = 1'b0; //record second point
        sw_down_tb = 1'b0;
        sw_left_tb = 1'b0; 
        //Test Draw rectangle enable using Black 
        sw_red_tb = 1'b0;
        sw_green_tb = 1'b0;
        sw_blue_tb = 1'b0;  
        draw_rectangle_tb = 1'b1;
        #60000000
        //Test Eraser, only clear the enable layer 
        draw_rectangle_tb = 1'b0;
        eraaser_tb = 1'b1;
        #120000000
        //Test Reset, clear all 
        eraaser_tb = 1'b0; 
        reset_tb = 1'b1;
    end
endmodule
