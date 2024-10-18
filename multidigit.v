module multidigit(
input clk,
 input [15:0] bcd_in,
 output [3:0] sseg_a_o,
 output [6:0] sseg_c_o);

parameter g_s = 7;
parameter gt = 6;

wire [6:0] sseg_o;
reg [3:0] anode =4'b0001;
reg [3:0] bcd_seg =4'b0000;
reg [g_s-1:0] g_count =0;

segConv uut1(clk, bcd_seg,sseg_o);


always @(posedge clk)
begin
    g_count = g_count+1;
    if(g_count == 0)
        begin
        if(anode == 4'b0001)
            begin
            anode = 4'b1000;
            end  
        else
            begin
            anode = anode >> 1;
            end
        end

    if(&g_count[g_s-1:gt])
        begin
        case (anode) //case statement
   
            4'b1000: bcd_seg  = bcd_in[15:12];
            4'b0100: bcd_seg  = bcd_in[11:8];
            4'b0010: bcd_seg  = bcd_in[7:4];
            4'b0001: bcd_seg  = bcd_in[3:0];
       
            default : bcd_seg = 4'b1111;
        endcase
        end
         
     else
        begin
        bcd_seg = 4'b1111;
        end

end

assign  sseg_a_o = ~anode;
assign  sseg_c_o = sseg_o;  


endmodule

module segConv(clk, bcd, seg);
    input clk;
    input [3:0] bcd;
    output reg[6:0] seg;//


    always @(posedge clk)    
    begin        
    case (bcd) //case statement                  
        0: seg = 7'b0000001;
        1: seg=7'b1001111;
        2: seg=7'b0010010;
        3: seg=7'b0000110;
        4: seg=7'b1001100;
        5: seg=7'b0100100;
        6: seg=7'b0100000;
        7: seg=7'b0001111;
        8: seg=7'b0000000;
        9: seg=7'b0000100;

        default : seg = 7'b1111111;                    
    endcase              
    end                

endmodule
