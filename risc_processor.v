//==============================================================================
// 8-BIT ADVANCED RISC PROCESSOR - COMPLETE WORKING VERSION
//==============================================================================

//============================= ALU ============================================
module alu(
    input [7:0] a,b,
    input [3:0] alu_op,
    output reg [7:0] result,
    output reg zero,carry,negative,overflow
);
    reg [8:0] temp;

    localparam ADD=4'b0000, SUB=4'b0001, AND=4'b0010, OR=4'b0011;

    always @(*) begin
        temp=0; result=0; carry=0; overflow=0;

        case(alu_op)
            ADD: begin
                temp=a+b;
                result=temp[7:0];
                carry=temp[8];
                overflow=(a[7]==b[7])&&(result[7]!=a[7]);
            end
            SUB: begin
                temp=a-b;
                result=temp[7:0];
                carry=temp[8];
                overflow=(a[7]!=b[7])&&(result[7]!=a[7]);
            end
            AND: result=a&b;
            OR : result=a|b;
        endcase

        zero=(result==0);
        negative=result[7];
    end
endmodule

//============================= REGISTER FILE =================================
module register_file(
    input clk,rst,we,
    input [2:0] ra1,ra2,wa,
    input [7:0] wd,
    output [7:0] rd1,rd2
);
    reg [7:0] r[0:7];
    integer i;

    assign rd1=r[ra1];
    assign rd2=r[ra2];

    always @(posedge clk or posedge rst) begin
        if(rst)
            for(i=0;i<8;i=i+1) r[i]<=0;
        else if(we)
            r[wa]<=wd;
    end
endmodule

//============================= PROGRAM COUNTER ================================
module program_counter(
    input clk,rst,load,inc,
    input [15:0] in,
    output reg [15:0] out
);
    always @(posedge clk or posedge rst)
        if(rst) out<=0;
        else if(load) out<=in;
        else if(inc) out<=out+1;
endmodule

//============================= INSTRUCTION MEMORY =============================
module instruction_memory(
    input [15:0] addr,
    output [7:0] inst
);
    reg [7:0] rom[0:255];
    integer i;

    assign inst=rom[addr];

    initial begin
        rom[0]=8'b00000001;
        rom[1]=8'b00000010;
        rom[2]=8'b00000011;
        rom[3]=8'b00000000;
        for(i=4;i<256;i=i+1) rom[i]=0;
    end
endmodule

//============================= DATA MEMORY ====================================
module data_memory(
    input clk,we,
    input [15:0] addr,
    input [7:0] din,
    output [7:0] dout
);
    reg [7:0] ram[0:255];
    integer i;

    assign dout=ram[addr];

    always @(posedge clk)
        if(we) ram[addr]<=din;

    initial
        for(i=0;i<256;i=i+1) ram[i]=0;
endmodule

//============================= CONTROL UNIT ===================================
module control_unit(
    input [7:0] inst,
    output reg reg_we,
    output reg pc_inc,
    output reg [3:0] alu_op
);
    always @(*) begin
        reg_we=0; pc_inc=1; alu_op=0;

        case(inst[7:5])
            3'b000: begin reg_we=1; alu_op=inst[4:1]; end
            3'b001: reg_we=1;
        endcase
    end
endmodule

//============================= TOP MODULE =====================================
module risc_processor_top(
    input clk,rst
);

    wire [15:0] pc_out;
    wire [7:0] inst;
    wire reg_we,pc_inc;
    wire [3:0] alu_op;
    wire [7:0] r1,r2,alu_res;
    wire z,c,n,v;

    program_counter pc(clk,rst,1'b0,pc_inc,16'b0,pc_out);
    instruction_memory im(pc_out,inst);

    control_unit cu(inst,reg_we,pc_inc,alu_op);

    register_file rf(clk,rst,reg_we,
                     inst[2:0],inst[5:3],inst[5:3],
                     alu_res,r1,r2);

    alu alu1(r1,r2,alu_op,alu_res,z,c,n,v);

endmodule
