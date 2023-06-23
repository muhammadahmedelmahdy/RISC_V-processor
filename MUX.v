/******************************************************************* *
* Module: MUX.v
* Project: Single Cycle RISCV Processor
* Author: Merna Abdelbadie and Mohammad El Mahdy
mernaabdelbadie@aucgypt.edu, muhammadahmedelmahdy@aucegypt.edu
*Description: This is a multiplexer module*
* Change history: 02/17/23 - Wrote the module
* **********************************************************************/

module MUX #(parameter N = 32)(
    input [N-1:0] in1,
    input [N-1:0] in2,
    input select,
    output [N-1:0] out
    );
    assign out = select ? in2 : in1 ;
endmodule
