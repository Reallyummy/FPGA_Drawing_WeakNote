WeakNote:
This project is being called WeakNote because it is not strong! Only simple drawing or writing functions are included. This FPGA project written in Verilog for Basys-3 board.
There are 9 (.v) files, please download all of them so that there will be no error. A testbench file(tb.v) and a constraint file(VGA.xdc) are included for your reference.
You need to connect the board to a screen with a VGA cable and this code only works with VGA connection.

Basic discription:
Weaknote allows users to draw and write different stuff on the screen. There are buttons allowing users to choose the color with RGB input (total 8 colors). With "enable" signal selected, you will be able to draw on
the layer you have chosen. There are 3 layers, while layer_1 is having the highest priority and layer_3 is having the least priority. So drawings on layer_3 will be covered by layer_1 or 2 etc. Special functions
include reset the layer, changing cursor size, changing cursor speed and drawing rectangles.

Rectangle drawing function:
When you flip the switch W13, the FPGA will record the (x,y) position of the cursor. When you flip the switch once more at another (x,y) position. The FPGA will record the current position as the second point. When
you enable drawing of the rectangle by flipping switch W14, a rectangle will form on the screen according to the 2 (x,y) position you have provided to the FPGA board.
(Sorry for making this function complicated, but we are nearly out of switch >_<)

Small problem:
1. The code can run normally on the basys3 board. But there is some timing problem. You might need to fix this if it really affects you.
