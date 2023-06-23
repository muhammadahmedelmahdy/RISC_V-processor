/******************************************************************* *
* Module: n_bit_shift.v
* Project: Single Cycle RISCV Processor
* Author: Merna Abdelbadie and Mohammad El Mahdy
mernaabdelbadie@aucgypt.edu, muhammadahmedelmahdy@aucegypt.edu
*Description: This module shifts an input one bit to the left*
* Change history: 03/06/23 - Wrote the module
* **********************************************************************/
module n_bit_shift #(parameter N = 32)(
    input [N-1:0] in,
    output [N-1:0] out
    );
    assign out = {in[N-2:0], 1'b0} ;
endmodule
