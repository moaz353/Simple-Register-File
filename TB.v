module register_file_TB ;

reg                clk   , rst    ; 
reg                wr_en , rd_en  ;
reg  [ 2  : 0 ]    ADDr           ; 
reg  [ 15 : 0 ]    wr_DATA        ;

wire [ 15 : 0 ]    rd_DATA        ; 


register_file DUT (
    .clk(clk),          
    .rst(rst),          
    .ADDr(ADDr),       
    .wr_en(wr_en),     
    .rd_en(rd_en),      
    .wr_DATA(wr_DATA),  
    .rd_DATA(rd_DATA)   
);

initial begin
    clk = 0 ; 
    forever #5 clk = ~clk ; 
end

initial begin 
    $readmemb ("mem.dat" , DUT.mem , 0 , 7 ) ;
    rst     = 1 ;
    wr_DATA = 0 ;
    wr_en   = 0 ; 
    rd_en   = 0 ;
    @(negedge clk) ; 
    rst     = 0 ;  
    wr_en   = 1 ; 
    repeat(500) begin 
        wr_DATA = $random ; 
        ADDr    = $random ; 
        @(negedge clk )   ; 
        display_message   ; 
    end
    wr_en = 0 ; 
    rd_en = 1 ; 
    repeat ( 700 ) begin 
        ADDr    = $random ;
        @(negedge clk )   ; 
        display_message   ; 

    end 
$stop ; 
end 

task  display_message ; 
begin 
    $display ( "memory address = %d ;  " , ADDr ) ; 
    $display ("write enable = %b ; write data = %d  ; read enable = %b ; read data = %d " ,
                        wr_en , wr_DATA, rd_en , rd_DATA ) ;
end 
endtask 

endmodule 


