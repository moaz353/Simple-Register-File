module register_file ( clk , rst , ADDr , wr_en , rd_en ,
                wr_DATA  , rd_DATA  );

parameter ADDr_WIDTH  = 10    ;
parameter mem_WIDTH   = 32    ; 
parameter mem_length  = 1024  ; 

input   clk ;
input   rst ; 
input   wr_en ;
input   rd_en  ;

input  [ ADDr_WIDTH-1  : 0 ] ADDr    ; 
input  [ mem_WIDTH -1  : 0 ] wr_DATA ;

output reg [ mem_WIDTH-1 : 0 ] rd_DATA ; 

reg [ mem_WIDTH-1 : 0 ] mem [ mem_length-1 : 0 ] ; 

always @(posedge clk) begin
    if(rst)
        rd_DATA <= 0 ; 
    else begin  
            if(wr_en) 
                mem[ADDr] <= wr_DATA ; 
            if(rd_en) 
                rd_DATA <= mem[ADDr] ; 
        end
    end 
endmodule