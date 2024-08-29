// SPDX-License-Identifier: Apache-2.0
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//Sequencer for MLDSA
//MLDSA functions
//  Keygen
//  Signing - challenge generation
//  Verify

`include "config_defines.svh"

module mldsa_seq_prim
  import mldsa_ctrl_pkg::*;
  (
  input logic clk,
  input logic rst_b,
  input logic zeroize,

  input  logic en_i,
  input  logic [MLDSA_PROG_ADDR_W-1 : 0] addr_i,
  output mldsa_seq_instr_t data_o
  );


  //----------------------------------------------------------------
  // ROM content
  //----------------------------------------------------------------
 
  always_ff @(posedge clk or negedge rst_b) begin
    if (!rst_b) begin
        data_o <= '0;
    end 
    else if (zeroize) begin
        data_o <= '0;
    end 
    else begin
        if (en_i) begin
            unique case(addr_i)
                //RESET
                MLDSA_RESET      : data_o <= '{opcode:MLDSA_UOP_NOP, imm:'h0000, length:'d00, operand1:MLDSA_NOP, operand2:MLDSA_NOP, operand3:MLDSA_NOP};

                //KEYGEN
                //(p,p',K)=Keccak(seed)
                //                                //SHAKE256 operation                              //SRC                 //SRC2            //DEST
                MLDSA_KG_S       : data_o <= '{opcode:MLDSA_UOP_SHAKE256, imm:'h0708, length:'d34, operand1:MLDSA_SEED_ID, operand2:MLDSA_NOP, operand3:MLDSA_DEST_K_RHO_REG_ID};
                //s1=expandS
                //                                //Rej Bounded op      //SRC imm              //SRC1                 //SRC2            //DEST
                MLDSA_KG_S+ 1    : data_o <= '{opcode:MLDSA_UOP_REJB, imm:'h0000, length:'d66, operand1:MLDSA_RHO_P_ID, operand2:MLDSA_NOP, operand3:MLDSA_S1_0_BASE};
                MLDSA_KG_S+ 2    : data_o <= '{opcode:MLDSA_UOP_REJB, imm:'h0001, length:'d66, operand1:MLDSA_RHO_P_ID, operand2:MLDSA_NOP, operand3:MLDSA_S1_1_BASE};
                MLDSA_KG_S+ 3    : data_o <= '{opcode:MLDSA_UOP_REJB, imm:'h0002, length:'d66, operand1:MLDSA_RHO_P_ID, operand2:MLDSA_NOP, operand3:MLDSA_S1_2_BASE};
                MLDSA_KG_S+ 4    : data_o <= '{opcode:MLDSA_UOP_REJB, imm:'h0003, length:'d66, operand1:MLDSA_RHO_P_ID, operand2:MLDSA_NOP, operand3:MLDSA_S1_3_BASE};
                MLDSA_KG_S+ 5    : data_o <= '{opcode:MLDSA_UOP_REJB, imm:'h0004, length:'d66, operand1:MLDSA_RHO_P_ID, operand2:MLDSA_NOP, operand3:MLDSA_S1_4_BASE};
                MLDSA_KG_S+ 6    : data_o <= '{opcode:MLDSA_UOP_REJB, imm:'h0005, length:'d66, operand1:MLDSA_RHO_P_ID, operand2:MLDSA_NOP, operand3:MLDSA_S1_5_BASE};
                MLDSA_KG_S+ 7    : data_o <= '{opcode:MLDSA_UOP_REJB, imm:'h0006, length:'d66, operand1:MLDSA_RHO_P_ID, operand2:MLDSA_NOP, operand3:MLDSA_S1_6_BASE};
                //s1=expandS
                MLDSA_KG_S+ 8    : data_o <= '{opcode:MLDSA_UOP_REJB, imm:'h0007, length:'d66, operand1:MLDSA_RHO_P_ID, operand2:MLDSA_NOP, operand3:MLDSA_S2_0_BASE};
                MLDSA_KG_S+ 9    : data_o <= '{opcode:MLDSA_UOP_REJB, imm:'h0008, length:'d66, operand1:MLDSA_RHO_P_ID, operand2:MLDSA_NOP, operand3:MLDSA_S2_1_BASE};
                MLDSA_KG_S+ 10   : data_o <= '{opcode:MLDSA_UOP_REJB, imm:'h0009, length:'d66, operand1:MLDSA_RHO_P_ID, operand2:MLDSA_NOP, operand3:MLDSA_S2_2_BASE};
                MLDSA_KG_S+ 11   : data_o <= '{opcode:MLDSA_UOP_REJB, imm:'h000A, length:'d66, operand1:MLDSA_RHO_P_ID, operand2:MLDSA_NOP, operand3:MLDSA_S2_3_BASE};
                MLDSA_KG_S+ 12   : data_o <= '{opcode:MLDSA_UOP_REJB, imm:'h000B, length:'d66, operand1:MLDSA_RHO_P_ID, operand2:MLDSA_NOP, operand3:MLDSA_S2_4_BASE};
                MLDSA_KG_S+ 13   : data_o <= '{opcode:MLDSA_UOP_REJB, imm:'h000C, length:'d66, operand1:MLDSA_RHO_P_ID, operand2:MLDSA_NOP, operand3:MLDSA_S2_5_BASE};
                MLDSA_KG_S+ 14   : data_o <= '{opcode:MLDSA_UOP_REJB, imm:'h000D, length:'d66, operand1:MLDSA_RHO_P_ID, operand2:MLDSA_NOP, operand3:MLDSA_S2_6_BASE};
                MLDSA_KG_S+ 15   : data_o <= '{opcode:MLDSA_UOP_REJB, imm:'h000E, length:'d66, operand1:MLDSA_RHO_P_ID, operand2:MLDSA_NOP, operand3:MLDSA_S2_7_BASE};
                //NTT(s1)
                MLDSA_KG_S+ 16   : data_o <= '{opcode:MLDSA_UOP_NTT,  imm:'h0000, length:'d00, operand1:MLDSA_S1_0_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_S1_0_NTT_BASE};
                MLDSA_KG_S+ 17   : data_o <= '{opcode:MLDSA_UOP_NTT,  imm:'h0000, length:'d00, operand1:MLDSA_S1_1_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_S1_1_NTT_BASE};
                MLDSA_KG_S+ 18   : data_o <= '{opcode:MLDSA_UOP_NTT,  imm:'h0000, length:'d00, operand1:MLDSA_S1_2_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_S1_2_NTT_BASE};
                MLDSA_KG_S+ 19   : data_o <= '{opcode:MLDSA_UOP_NTT,  imm:'h0000, length:'d00, operand1:MLDSA_S1_3_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_S1_3_NTT_BASE};
                MLDSA_KG_S+ 20   : data_o <= '{opcode:MLDSA_UOP_NTT,  imm:'h0000, length:'d00, operand1:MLDSA_S1_4_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_S1_4_NTT_BASE};
                MLDSA_KG_S+ 21   : data_o <= '{opcode:MLDSA_UOP_NTT,  imm:'h0000, length:'d00, operand1:MLDSA_S1_5_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_S1_5_NTT_BASE};
                MLDSA_KG_S+ 22   : data_o <= '{opcode:MLDSA_UOP_NTT,  imm:'h0000, length:'d00, operand1:MLDSA_S1_6_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_S1_6_NTT_BASE};
                //ExpandA(ρ) AND Aˆ NTT(s1)
                MLDSA_KG_S+ 23   : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0000, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_0_NTT_BASE, operand3:MLDSA_AS0_BASE};
                MLDSA_KG_S+ 24   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0001, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_1_NTT_BASE, operand3:MLDSA_AS0_BASE};
                MLDSA_KG_S+ 25   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0002, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_2_NTT_BASE, operand3:MLDSA_AS0_BASE};
                MLDSA_KG_S+ 26   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0003, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_3_NTT_BASE, operand3:MLDSA_AS0_BASE};
                MLDSA_KG_S+ 27   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0004, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_4_NTT_BASE, operand3:MLDSA_AS0_BASE};
                MLDSA_KG_S+ 28   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0005, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_5_NTT_BASE, operand3:MLDSA_AS0_BASE};
                MLDSA_KG_S+ 29   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0006, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_6_NTT_BASE, operand3:MLDSA_AS0_BASE};

                MLDSA_KG_S+ 30   : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0100, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_0_NTT_BASE, operand3:MLDSA_AS1_BASE};
                MLDSA_KG_S+ 31   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0101, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_1_NTT_BASE, operand3:MLDSA_AS1_BASE};
                MLDSA_KG_S+ 32   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0102, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_2_NTT_BASE, operand3:MLDSA_AS1_BASE};
                MLDSA_KG_S+ 33   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0103, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_3_NTT_BASE, operand3:MLDSA_AS1_BASE};
                MLDSA_KG_S+ 34   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0104, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_4_NTT_BASE, operand3:MLDSA_AS1_BASE};
                MLDSA_KG_S+ 35   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0105, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_5_NTT_BASE, operand3:MLDSA_AS1_BASE};
                MLDSA_KG_S+ 36   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0106, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_6_NTT_BASE, operand3:MLDSA_AS1_BASE};

                MLDSA_KG_S+ 37   : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0200, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_0_NTT_BASE, operand3:MLDSA_AS2_BASE};
                MLDSA_KG_S+ 38   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0201, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_1_NTT_BASE, operand3:MLDSA_AS2_BASE};
                MLDSA_KG_S+ 39   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0202, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_2_NTT_BASE, operand3:MLDSA_AS2_BASE};
                MLDSA_KG_S+ 40   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0203, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_3_NTT_BASE, operand3:MLDSA_AS2_BASE};
                MLDSA_KG_S+ 41   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0204, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_4_NTT_BASE, operand3:MLDSA_AS2_BASE};
                MLDSA_KG_S+ 42   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0205, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_5_NTT_BASE, operand3:MLDSA_AS2_BASE};
                MLDSA_KG_S+ 43   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0206, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_6_NTT_BASE, operand3:MLDSA_AS2_BASE};

                MLDSA_KG_S+ 44   : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0300, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_0_NTT_BASE, operand3:MLDSA_AS3_BASE};
                MLDSA_KG_S+ 45   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0301, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_1_NTT_BASE, operand3:MLDSA_AS3_BASE};
                MLDSA_KG_S+ 46   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0302, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_2_NTT_BASE, operand3:MLDSA_AS3_BASE};
                MLDSA_KG_S+ 47   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0303, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_3_NTT_BASE, operand3:MLDSA_AS3_BASE};
                MLDSA_KG_S+ 48   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0304, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_4_NTT_BASE, operand3:MLDSA_AS3_BASE};
                MLDSA_KG_S+ 49   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0305, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_5_NTT_BASE, operand3:MLDSA_AS3_BASE};
                MLDSA_KG_S+ 50   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0306, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_6_NTT_BASE, operand3:MLDSA_AS3_BASE};

                MLDSA_KG_S+ 51   : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0400, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_0_NTT_BASE, operand3:MLDSA_AS4_BASE};
                MLDSA_KG_S+ 52   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0401, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_1_NTT_BASE, operand3:MLDSA_AS4_BASE};
                MLDSA_KG_S+ 53   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0402, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_2_NTT_BASE, operand3:MLDSA_AS4_BASE};
                MLDSA_KG_S+ 54   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0403, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_3_NTT_BASE, operand3:MLDSA_AS4_BASE};
                MLDSA_KG_S+ 55   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0404, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_4_NTT_BASE, operand3:MLDSA_AS4_BASE};
                MLDSA_KG_S+ 56   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0405, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_5_NTT_BASE, operand3:MLDSA_AS4_BASE};
                MLDSA_KG_S+ 57   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0406, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_6_NTT_BASE, operand3:MLDSA_AS4_BASE};

                MLDSA_KG_S+ 58   : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0500, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_0_NTT_BASE, operand3:MLDSA_AS5_BASE};
                MLDSA_KG_S+ 59   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0501, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_1_NTT_BASE, operand3:MLDSA_AS5_BASE};
                MLDSA_KG_S+ 60   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0502, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_2_NTT_BASE, operand3:MLDSA_AS5_BASE};
                MLDSA_KG_S+ 61   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0503, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_3_NTT_BASE, operand3:MLDSA_AS5_BASE};
                MLDSA_KG_S+ 62   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0504, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_4_NTT_BASE, operand3:MLDSA_AS5_BASE};
                MLDSA_KG_S+ 63   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0505, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_5_NTT_BASE, operand3:MLDSA_AS5_BASE};
                MLDSA_KG_S+ 64   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0506, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_6_NTT_BASE, operand3:MLDSA_AS5_BASE};

                MLDSA_KG_S+ 65   : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0600, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_0_NTT_BASE, operand3:MLDSA_AS6_BASE};
                MLDSA_KG_S+ 66   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0601, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_1_NTT_BASE, operand3:MLDSA_AS6_BASE};
                MLDSA_KG_S+ 67   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0602, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_2_NTT_BASE, operand3:MLDSA_AS6_BASE};
                MLDSA_KG_S+ 68   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0603, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_3_NTT_BASE, operand3:MLDSA_AS6_BASE};
                MLDSA_KG_S+ 69   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0604, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_4_NTT_BASE, operand3:MLDSA_AS6_BASE};
                MLDSA_KG_S+ 70   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0605, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_5_NTT_BASE, operand3:MLDSA_AS6_BASE};
                MLDSA_KG_S+ 71   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0606, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_6_NTT_BASE, operand3:MLDSA_AS6_BASE};

                MLDSA_KG_S+ 72   : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0700, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_0_NTT_BASE, operand3:MLDSA_AS7_BASE};
                MLDSA_KG_S+ 73   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0701, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_1_NTT_BASE, operand3:MLDSA_AS7_BASE};
                MLDSA_KG_S+ 74   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0702, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_2_NTT_BASE, operand3:MLDSA_AS7_BASE};
                MLDSA_KG_S+ 75   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0703, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_3_NTT_BASE, operand3:MLDSA_AS7_BASE};
                MLDSA_KG_S+ 76   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0704, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_4_NTT_BASE, operand3:MLDSA_AS7_BASE};
                MLDSA_KG_S+ 77   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0705, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_5_NTT_BASE, operand3:MLDSA_AS7_BASE};
                MLDSA_KG_S+ 78   : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0706, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_S1_6_NTT_BASE, operand3:MLDSA_AS7_BASE};
                //NTT−1(Aˆ ◦NTT(s1))
                MLDSA_KG_S+ 79   : data_o <= '{opcode:MLDSA_UOP_INTT, imm:'d00, length:'d00, operand1:MLDSA_AS0_BASE, operand2:MLDSA_TEMP3_BASE, operand3:MLDSA_AS0_INTT_BASE};
                MLDSA_KG_S+ 80   : data_o <= '{opcode:MLDSA_UOP_INTT, imm:'d00, length:'d00, operand1:MLDSA_AS1_BASE, operand2:MLDSA_TEMP3_BASE, operand3:MLDSA_AS1_INTT_BASE};
                MLDSA_KG_S+ 81   : data_o <= '{opcode:MLDSA_UOP_INTT, imm:'d00, length:'d00, operand1:MLDSA_AS2_BASE, operand2:MLDSA_TEMP3_BASE, operand3:MLDSA_AS2_INTT_BASE};
                MLDSA_KG_S+ 82   : data_o <= '{opcode:MLDSA_UOP_INTT, imm:'d00, length:'d00, operand1:MLDSA_AS3_BASE, operand2:MLDSA_TEMP3_BASE, operand3:MLDSA_AS3_INTT_BASE};
                MLDSA_KG_S+ 83   : data_o <= '{opcode:MLDSA_UOP_INTT, imm:'d00, length:'d00, operand1:MLDSA_AS4_BASE, operand2:MLDSA_TEMP3_BASE, operand3:MLDSA_AS4_INTT_BASE};
                MLDSA_KG_S+ 84   : data_o <= '{opcode:MLDSA_UOP_INTT, imm:'d00, length:'d00, operand1:MLDSA_AS5_BASE, operand2:MLDSA_TEMP3_BASE, operand3:MLDSA_AS5_INTT_BASE};
                MLDSA_KG_S+ 85   : data_o <= '{opcode:MLDSA_UOP_INTT, imm:'d00, length:'d00, operand1:MLDSA_AS6_BASE, operand2:MLDSA_TEMP3_BASE, operand3:MLDSA_AS6_INTT_BASE};
                MLDSA_KG_S+ 86   : data_o <= '{opcode:MLDSA_UOP_INTT, imm:'d00, length:'d00, operand1:MLDSA_AS7_BASE, operand2:MLDSA_TEMP3_BASE, operand3:MLDSA_AS7_INTT_BASE};
                //t ←NTT−1(Aˆ ◦NTT(s1))+s2
                MLDSA_KG_S+ 87   : data_o <= '{opcode:MLDSA_UOP_PWA, imm:'d00, length:'d00, operand1:MLDSA_AS0_INTT_BASE, operand2:MLDSA_S2_0_BASE, operand3:MLDSA_T0_BASE};
                MLDSA_KG_S+ 88   : data_o <= '{opcode:MLDSA_UOP_PWA, imm:'d00, length:'d00, operand1:MLDSA_AS1_INTT_BASE, operand2:MLDSA_S2_1_BASE, operand3:MLDSA_T1_BASE};
                MLDSA_KG_S+ 89   : data_o <= '{opcode:MLDSA_UOP_PWA, imm:'d00, length:'d00, operand1:MLDSA_AS2_INTT_BASE, operand2:MLDSA_S2_2_BASE, operand3:MLDSA_T2_BASE};
                MLDSA_KG_S+ 90   : data_o <= '{opcode:MLDSA_UOP_PWA, imm:'d00, length:'d00, operand1:MLDSA_AS3_INTT_BASE, operand2:MLDSA_S2_3_BASE, operand3:MLDSA_T3_BASE};
                MLDSA_KG_S+ 91   : data_o <= '{opcode:MLDSA_UOP_PWA, imm:'d00, length:'d00, operand1:MLDSA_AS4_INTT_BASE, operand2:MLDSA_S2_4_BASE, operand3:MLDSA_T4_BASE};
                MLDSA_KG_S+ 92   : data_o <= '{opcode:MLDSA_UOP_PWA, imm:'d00, length:'d00, operand1:MLDSA_AS5_INTT_BASE, operand2:MLDSA_S2_5_BASE, operand3:MLDSA_T5_BASE};
                MLDSA_KG_S+ 93   : data_o <= '{opcode:MLDSA_UOP_PWA, imm:'d00, length:'d00, operand1:MLDSA_AS6_INTT_BASE, operand2:MLDSA_S2_6_BASE, operand3:MLDSA_T6_BASE};
                MLDSA_KG_S+ 94   : data_o <= '{opcode:MLDSA_UOP_PWA, imm:'d00, length:'d00, operand1:MLDSA_AS7_INTT_BASE, operand2:MLDSA_S2_7_BASE, operand3:MLDSA_T7_BASE};
                //(t1,t0)←Power2Round(t,d) AND pk ←pkEncode(ρ,t1)
                MLDSA_KG_S+ 95 : data_o <= '{opcode:MLDSA_UOP_PWR2RND, imm:'h0000, length:'d00, operand1:MLDSA_T0_BASE, operand2:MLDSA_NOP, operand3:MLDSA_NOP};
                //tr ←H(BytesToBits(pk),512)
                MLDSA_KG_S+ 96 : data_o <= '{opcode:MLDSA_UOP_SHAKE256, imm:'h0000, length:PUBKEY_NUM_BYTES, operand1:MLDSA_PK_REG_ID, operand2:MLDSA_NOP, operand3:MLDSA_DEST_TR_REG_ID};
                MLDSA_KG_JUMP_SIGN : data_o <= '{opcode:MLDSA_UOP_NOP, imm:'h0000, length:'d00, operand1:MLDSA_NOP, operand2:MLDSA_NOP, operand3:MLDSA_NOP};
                //sk ←skEncode(ρ,K,tr,s1,s2,t0)
                MLDSA_KG_S+ 98: data_o <= '{opcode:MLDSA_UOP_SKENCODE, imm:'h0000, length:'d00, operand1:MLDSA_S1_0_BASE, operand2:MLDSA_NOP, operand3:MLDSA_NOP};
                //KG end
                MLDSA_KG_E       : data_o <= '{opcode:MLDSA_UOP_NOP, imm:'h0000, length:'d00, operand1:MLDSA_NOP, operand2:MLDSA_NOP, operand3:MLDSA_NOP};

                //Signing start
                //μ ←H(tr||M,512)
                MLDSA_SIGN_S     : data_o <= '{opcode:MLDSA_UOP_LD_SHAKE256, imm:'h0000, length:'d64, operand1:MLDSA_TR_ID, operand2:MLDSA_NOP, operand3:MLDSA_NOP};
                MLDSA_SIGN_S+ 1  : data_o <= '{opcode:MLDSA_UOP_SHAKE256, imm:'h0000, length:'d77, operand1:MLDSA_MSG_ID, operand2:MLDSA_NOP, operand3:MLDSA_DEST_MU_REG_ID};
                //ρ′=Keccak(K||rnd|| μ)
                MLDSA_SIGN_S+ 2  : data_o <= '{opcode:MLDSA_UOP_LD_SHAKE256, imm:'h0000, length:'d32, operand1:MLDSA_K_ID, operand2:MLDSA_NOP, operand3:MLDSA_NOP};
                MLDSA_SIGN_S+ 3  : data_o <= '{opcode:MLDSA_UOP_LD_SHAKE256, imm:'h0000, length:'d32, operand1:MLDSA_SIGN_RND_ID, operand2:MLDSA_NOP, operand3:MLDSA_NOP};
                MLDSA_SIGN_S+ 4  : data_o <= '{opcode:MLDSA_UOP_SHAKE256, imm:'h0000, length:'d64, operand1:MLDSA_MU_ID, operand2:MLDSA_NOP, operand3:MLDSA_DEST_RHO_P_REG_ID};
                //Check Y valid
                MLDSA_SIGN_CHECK_Y_CLR  : data_o <= '{opcode:MLDSA_UOP_NOP, imm:'h0000, length:'d00, operand1:MLDSA_UOP_NOP, operand2:MLDSA_NOP, operand3:MLDSA_NOP};
                //y=ExpandMask(ρ’ ,κ)
                MLDSA_SIGN_MAKE_Y_S     : data_o <= '{opcode:MLDSA_UOP_EXP_MASK, imm:'h0000, length:'d66, operand1:MLDSA_RHO_P_KAPPA_ID, operand2:MLDSA_NOP, operand3:MLDSA_Y_0_BASE};
                MLDSA_SIGN_MAKE_Y_S+ 1  : data_o <= '{opcode:MLDSA_UOP_EXP_MASK, imm:'h0001, length:'d66, operand1:MLDSA_RHO_P_KAPPA_ID, operand2:MLDSA_NOP, operand3:MLDSA_Y_1_BASE};
                MLDSA_SIGN_MAKE_Y_S+ 2  : data_o <= '{opcode:MLDSA_UOP_EXP_MASK, imm:'h0002, length:'d66, operand1:MLDSA_RHO_P_KAPPA_ID, operand2:MLDSA_NOP, operand3:MLDSA_Y_2_BASE};
                MLDSA_SIGN_MAKE_Y_S+ 3  : data_o <= '{opcode:MLDSA_UOP_EXP_MASK, imm:'h0003, length:'d66, operand1:MLDSA_RHO_P_KAPPA_ID, operand2:MLDSA_NOP, operand3:MLDSA_Y_3_BASE};
                MLDSA_SIGN_MAKE_Y_S+ 4  : data_o <= '{opcode:MLDSA_UOP_EXP_MASK, imm:'h0004, length:'d66, operand1:MLDSA_RHO_P_KAPPA_ID, operand2:MLDSA_NOP, operand3:MLDSA_Y_4_BASE};
                MLDSA_SIGN_MAKE_Y_S+ 5  : data_o <= '{opcode:MLDSA_UOP_EXP_MASK, imm:'h0005, length:'d66, operand1:MLDSA_RHO_P_KAPPA_ID, operand2:MLDSA_NOP, operand3:MLDSA_Y_5_BASE};
                MLDSA_SIGN_MAKE_Y_S+ 6  : data_o <= '{opcode:MLDSA_UOP_EXP_MASK, imm:'h0006, length:'d66, operand1:MLDSA_RHO_P_KAPPA_ID, operand2:MLDSA_NOP, operand3:MLDSA_Y_6_BASE};
                //NTT(Y)
                MLDSA_SIGN_MAKE_Y_S+ 7  : data_o <= '{opcode:MLDSA_UOP_NTT,  imm:'h0000, length:'d00, operand1:MLDSA_Y_0_BASE, operand2:MLDSA_TEMP3_BASE, operand3:MLDSA_Y_0_NTT_BASE};
                MLDSA_SIGN_MAKE_Y_S+ 8  : data_o <= '{opcode:MLDSA_UOP_NTT,  imm:'h0000, length:'d00, operand1:MLDSA_Y_1_BASE, operand2:MLDSA_TEMP3_BASE, operand3:MLDSA_Y_1_NTT_BASE};
                MLDSA_SIGN_MAKE_Y_S+ 9  : data_o <= '{opcode:MLDSA_UOP_NTT,  imm:'h0000, length:'d00, operand1:MLDSA_Y_2_BASE, operand2:MLDSA_TEMP3_BASE, operand3:MLDSA_Y_2_NTT_BASE};
                MLDSA_SIGN_MAKE_Y_S+ 10 : data_o <= '{opcode:MLDSA_UOP_NTT,  imm:'h0000, length:'d00, operand1:MLDSA_Y_3_BASE, operand2:MLDSA_TEMP3_BASE, operand3:MLDSA_Y_3_NTT_BASE};
                MLDSA_SIGN_MAKE_Y_S+ 11 : data_o <= '{opcode:MLDSA_UOP_NTT,  imm:'h0000, length:'d00, operand1:MLDSA_Y_4_BASE, operand2:MLDSA_TEMP3_BASE, operand3:MLDSA_Y_4_NTT_BASE};
                MLDSA_SIGN_MAKE_Y_S+ 12 : data_o <= '{opcode:MLDSA_UOP_NTT,  imm:'h0000, length:'d00, operand1:MLDSA_Y_5_BASE, operand2:MLDSA_TEMP3_BASE, operand3:MLDSA_Y_5_NTT_BASE};
                MLDSA_SIGN_MAKE_Y_S+ 13 : data_o <= '{opcode:MLDSA_UOP_NTT,  imm:'h0000, length:'d00, operand1:MLDSA_Y_6_BASE, operand2:MLDSA_TEMP3_BASE, operand3:MLDSA_Y_6_NTT_BASE};
                //Aˆ ←ExpandA(ρ) AND Aˆ ◦NTT(y)
                MLDSA_SIGN_MAKE_W_S     : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0000, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_0_NTT_BASE, operand3:MLDSA_AY0_BASE};
                MLDSA_SIGN_MAKE_W_S+ 1  : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0001, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_1_NTT_BASE, operand3:MLDSA_AY0_BASE};
                MLDSA_SIGN_MAKE_W_S+ 2  : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0002, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_2_NTT_BASE, operand3:MLDSA_AY0_BASE};
                MLDSA_SIGN_MAKE_W_S+ 3  : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0003, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_3_NTT_BASE, operand3:MLDSA_AY0_BASE};
                MLDSA_SIGN_MAKE_W_S+ 4  : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0004, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_4_NTT_BASE, operand3:MLDSA_AY0_BASE};
                MLDSA_SIGN_MAKE_W_S+ 5  : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0005, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_5_NTT_BASE, operand3:MLDSA_AY0_BASE};
                MLDSA_SIGN_MAKE_W_S+ 6  : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0006, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_6_NTT_BASE, operand3:MLDSA_AY0_BASE};

                MLDSA_SIGN_MAKE_W_S+ 7  : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0100, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_0_NTT_BASE, operand3:MLDSA_AY1_BASE};
                MLDSA_SIGN_MAKE_W_S+ 8  : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0101, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_1_NTT_BASE, operand3:MLDSA_AY1_BASE};
                MLDSA_SIGN_MAKE_W_S+ 9  : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0102, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_2_NTT_BASE, operand3:MLDSA_AY1_BASE};
                MLDSA_SIGN_MAKE_W_S+ 10 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0103, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_3_NTT_BASE, operand3:MLDSA_AY1_BASE};
                MLDSA_SIGN_MAKE_W_S+ 11 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0104, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_4_NTT_BASE, operand3:MLDSA_AY1_BASE};
                MLDSA_SIGN_MAKE_W_S+ 12 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0105, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_5_NTT_BASE, operand3:MLDSA_AY1_BASE};
                MLDSA_SIGN_MAKE_W_S+ 13 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0106, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_6_NTT_BASE, operand3:MLDSA_AY1_BASE};
                
                MLDSA_SIGN_MAKE_W_S+ 14 : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0200, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_0_NTT_BASE, operand3:MLDSA_AY2_BASE};
                MLDSA_SIGN_MAKE_W_S+ 15 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0201, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_1_NTT_BASE, operand3:MLDSA_AY2_BASE};
                MLDSA_SIGN_MAKE_W_S+ 16 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0202, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_2_NTT_BASE, operand3:MLDSA_AY2_BASE};
                MLDSA_SIGN_MAKE_W_S+ 17 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0203, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_3_NTT_BASE, operand3:MLDSA_AY2_BASE};
                MLDSA_SIGN_MAKE_W_S+ 18 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0204, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_4_NTT_BASE, operand3:MLDSA_AY2_BASE};
                MLDSA_SIGN_MAKE_W_S+ 19 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0205, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_5_NTT_BASE, operand3:MLDSA_AY2_BASE};
                MLDSA_SIGN_MAKE_W_S+ 20 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0206, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_6_NTT_BASE, operand3:MLDSA_AY2_BASE};
                
                MLDSA_SIGN_MAKE_W_S+ 21 : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0300, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_0_NTT_BASE, operand3:MLDSA_AY3_BASE};
                MLDSA_SIGN_MAKE_W_S+ 22 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0301, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_1_NTT_BASE, operand3:MLDSA_AY3_BASE};
                MLDSA_SIGN_MAKE_W_S+ 23 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0302, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_2_NTT_BASE, operand3:MLDSA_AY3_BASE};
                MLDSA_SIGN_MAKE_W_S+ 24 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0303, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_3_NTT_BASE, operand3:MLDSA_AY3_BASE};
                MLDSA_SIGN_MAKE_W_S+ 25 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0304, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_4_NTT_BASE, operand3:MLDSA_AY3_BASE};
                MLDSA_SIGN_MAKE_W_S+ 26 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0305, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_5_NTT_BASE, operand3:MLDSA_AY3_BASE};
                MLDSA_SIGN_MAKE_W_S+ 27 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0306, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_6_NTT_BASE, operand3:MLDSA_AY3_BASE};

                MLDSA_SIGN_MAKE_W_S+ 28 : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0400, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_0_NTT_BASE, operand3:MLDSA_AY4_BASE};
                MLDSA_SIGN_MAKE_W_S+ 29 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0401, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_1_NTT_BASE, operand3:MLDSA_AY4_BASE};
                MLDSA_SIGN_MAKE_W_S+ 30 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0402, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_2_NTT_BASE, operand3:MLDSA_AY4_BASE};
                MLDSA_SIGN_MAKE_W_S+ 31 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0403, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_3_NTT_BASE, operand3:MLDSA_AY4_BASE};
                MLDSA_SIGN_MAKE_W_S+ 32 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0404, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_4_NTT_BASE, operand3:MLDSA_AY4_BASE};
                MLDSA_SIGN_MAKE_W_S+ 33 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0405, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_5_NTT_BASE, operand3:MLDSA_AY4_BASE};
                MLDSA_SIGN_MAKE_W_S+ 34 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0406, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_6_NTT_BASE, operand3:MLDSA_AY4_BASE};
    
                MLDSA_SIGN_MAKE_W_S+ 35 : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0500, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_0_NTT_BASE, operand3:MLDSA_AY5_BASE};
                MLDSA_SIGN_MAKE_W_S+ 36 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0501, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_1_NTT_BASE, operand3:MLDSA_AY5_BASE};
                MLDSA_SIGN_MAKE_W_S+ 37 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0502, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_2_NTT_BASE, operand3:MLDSA_AY5_BASE};
                MLDSA_SIGN_MAKE_W_S+ 38 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0503, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_3_NTT_BASE, operand3:MLDSA_AY5_BASE};
                MLDSA_SIGN_MAKE_W_S+ 39 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0504, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_4_NTT_BASE, operand3:MLDSA_AY5_BASE};
                MLDSA_SIGN_MAKE_W_S+ 40 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0505, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_5_NTT_BASE, operand3:MLDSA_AY5_BASE};
                MLDSA_SIGN_MAKE_W_S+ 41 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0506, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_6_NTT_BASE, operand3:MLDSA_AY5_BASE};
                
                MLDSA_SIGN_MAKE_W_S+ 42 : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0600, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_0_NTT_BASE, operand3:MLDSA_AY6_BASE};
                MLDSA_SIGN_MAKE_W_S+ 43 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0601, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_1_NTT_BASE, operand3:MLDSA_AY6_BASE};
                MLDSA_SIGN_MAKE_W_S+ 44 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0602, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_2_NTT_BASE, operand3:MLDSA_AY6_BASE};
                MLDSA_SIGN_MAKE_W_S+ 45 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0603, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_3_NTT_BASE, operand3:MLDSA_AY6_BASE};
                MLDSA_SIGN_MAKE_W_S+ 46 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0604, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_4_NTT_BASE, operand3:MLDSA_AY6_BASE};
                MLDSA_SIGN_MAKE_W_S+ 47 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0605, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_5_NTT_BASE, operand3:MLDSA_AY6_BASE};
                MLDSA_SIGN_MAKE_W_S+ 48 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0606, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_6_NTT_BASE, operand3:MLDSA_AY6_BASE};
                
                MLDSA_SIGN_MAKE_W_S+ 49 : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0700, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_0_NTT_BASE, operand3:MLDSA_AY7_BASE};
                MLDSA_SIGN_MAKE_W_S+ 50 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0701, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_1_NTT_BASE, operand3:MLDSA_AY7_BASE};
                MLDSA_SIGN_MAKE_W_S+ 51 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0702, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_2_NTT_BASE, operand3:MLDSA_AY7_BASE};
                MLDSA_SIGN_MAKE_W_S+ 52 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0703, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_3_NTT_BASE, operand3:MLDSA_AY7_BASE};
                MLDSA_SIGN_MAKE_W_S+ 53 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0704, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_4_NTT_BASE, operand3:MLDSA_AY7_BASE};
                MLDSA_SIGN_MAKE_W_S+ 54 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0705, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_5_NTT_BASE, operand3:MLDSA_AY7_BASE};
                MLDSA_SIGN_MAKE_W_S+ 55 : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0706, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Y_6_NTT_BASE, operand3:MLDSA_AY7_BASE};
                //Set Y valid //FIXME this can move before MAKE_W if we opt accumulator to not have to read dest
                MLDSA_SIGN_SET_Y        : data_o <= '{opcode:MLDSA_UOP_NOP, imm:'h0000, length:'d00, operand1:MLDSA_UOP_NOP, operand2:MLDSA_NOP, operand3:MLDSA_NOP};
                //w ←NTT−1(Aˆ ◦NTT(y))
                //Check W0 clear
                MLDSA_SIGN_CHECK_W0_CLR : data_o <= '{opcode:MLDSA_UOP_NOP, imm:'h0000, length:'d00, operand1:MLDSA_NOP, operand2:MLDSA_NOP, operand3:MLDSA_NOP};
                MLDSA_SIGN_MAKE_W_S+ 58 : data_o <= '{opcode:MLDSA_UOP_INTT,  imm:'h0000, length:'d00, operand1:MLDSA_AY0_BASE, operand2:MLDSA_TEMP3_BASE, operand3:MLDSA_W_0_BASE};
                MLDSA_SIGN_MAKE_W_S+ 59 : data_o <= '{opcode:MLDSA_UOP_INTT,  imm:'h0000, length:'d00, operand1:MLDSA_AY1_BASE, operand2:MLDSA_TEMP3_BASE, operand3:MLDSA_W_1_BASE};
                MLDSA_SIGN_MAKE_W_S+ 60 : data_o <= '{opcode:MLDSA_UOP_INTT,  imm:'h0000, length:'d00, operand1:MLDSA_AY2_BASE, operand2:MLDSA_TEMP3_BASE, operand3:MLDSA_W_2_BASE};
                MLDSA_SIGN_MAKE_W_S+ 61 : data_o <= '{opcode:MLDSA_UOP_INTT,  imm:'h0000, length:'d00, operand1:MLDSA_AY3_BASE, operand2:MLDSA_TEMP3_BASE, operand3:MLDSA_W_3_BASE};
                MLDSA_SIGN_MAKE_W_S+ 62 : data_o <= '{opcode:MLDSA_UOP_INTT,  imm:'h0000, length:'d00, operand1:MLDSA_AY4_BASE, operand2:MLDSA_TEMP3_BASE, operand3:MLDSA_W_4_BASE};
                MLDSA_SIGN_MAKE_W_S+ 63 : data_o <= '{opcode:MLDSA_UOP_INTT,  imm:'h0000, length:'d00, operand1:MLDSA_AY5_BASE, operand2:MLDSA_TEMP3_BASE, operand3:MLDSA_W_5_BASE};
                MLDSA_SIGN_MAKE_W_S+ 64 : data_o <= '{opcode:MLDSA_UOP_INTT,  imm:'h0000, length:'d00, operand1:MLDSA_AY6_BASE, operand2:MLDSA_TEMP3_BASE, operand3:MLDSA_W_6_BASE};
                MLDSA_SIGN_MAKE_W_S+ 65 : data_o <= '{opcode:MLDSA_UOP_INTT,  imm:'h0000, length:'d00, operand1:MLDSA_AY7_BASE, operand2:MLDSA_TEMP3_BASE, operand3:MLDSA_W_7_BASE};
                //(w1,w0) ←Decompose(w) AND c˜←H(μ||w1Encode(w1),2λ)
                MLDSA_SIGN_MAKE_W_S+ 66 : data_o <= '{opcode:MLDSA_UOP_LD_SHAKE256, imm:'h0000, length:'d64, operand1:MLDSA_MU_ID, operand2:MLDSA_NOP, operand3:MLDSA_NOP};
                MLDSA_SIGN_MAKE_W       : data_o <= '{opcode:MLDSA_UOP_DECOMP, imm:'h0000, length:'d00, operand1:MLDSA_W_0_BASE, operand2:MLDSA_NOP, operand3:MLDSA_W0_0_BASE}; 
                MLDSA_SIGN_SET_W0       : data_o <= '{opcode:MLDSA_UOP_NOP, imm:'h0000, length:'d00, operand1:MLDSA_NOP, operand2:MLDSA_NOP, operand3:MLDSA_NOP};
                // c ←SampleInBall(c˜1)
                //Check C clear
                MLDSA_SIGN_CHECK_C_CLR  : data_o <= '{opcode:MLDSA_UOP_NOP, imm:'h0000, length:'d00, operand1:MLDSA_NOP, operand2:MLDSA_NOP, operand3:MLDSA_NOP};
                MLDSA_SIGN_MAKE_C       : data_o <= '{opcode:MLDSA_UOP_RUN_SHAKE256, imm:'h0000, length:'d00, operand1:MLDSA_NOP, operand2:MLDSA_NOP, operand3:MLDSA_DEST_SIG_C_REG_ID};
                MLDSA_SIGN_MAKE_C+ 1    : data_o <= '{opcode:MLDSA_UOP_SIB, imm:'h0000, length:'d64, operand1:MLDSA_SIG_C_REG_ID, operand2:MLDSA_NOP, operand3:MLDSA_NOP};
                MLDSA_SIGN_SET_C        : data_o <= '{opcode:MLDSA_UOP_NOP, imm:'h0000, length:'d00, operand1:MLDSA_NOP, operand2:MLDSA_NOP, operand3:MLDSA_NOP};

                MLDSA_SIGN_E            : data_o <= '{opcode:MLDSA_UOP_NOP, imm:'h0000, length:'d00, operand1:MLDSA_NOP, operand2:MLDSA_NOP, operand3:MLDSA_NOP};

                //Verify flow
                //(ρ,t1)←pkDecode(pk)
                MLDSA_VERIFY_S          : data_o <= '{opcode:MLDSA_UOP_PKDECODE, imm:'h0000, length:'d00, operand1:MLDSA_NOP, operand2:MLDSA_NOP, operand3:MLDSA_T0_BASE};
                //(c˜,z,h)←sigDecode(σ) 
                MLDSA_VERIFY_S+ 1       : data_o <= '{opcode:MLDSA_UOP_SIGDEC_Z, imm:'h0000, length:'d00, operand1:MLDSA_NOP, operand2:MLDSA_NOP, operand3:MLDSA_Z_0_BASE};
                MLDSA_VERIFY_S+ 2       : data_o <= '{opcode:MLDSA_UOP_SIGDEC_H, imm:'h0000, length:'d00, operand1:MLDSA_NOP, operand2:MLDSA_NOP, operand3:MLDSA_HINT_R_0_BASE};
                //||z||∞ ≥ γ1 −β
                MLDSA_VERIFY_S+ 3       : data_o <= '{opcode:MLDSA_UOP_NORMCHK, imm:MLDSA_NORMCHK_Z, length:'d00, operand1:MLDSA_Z_0_BASE, operand2:MLDSA_NOP, operand3:MLDSA_NOP};
                //[[number of 1’s in h is ≤ ω]]
                //MLDSA_VERIFY_S+ 4       : data_o <= '{opcode:MLDSA_UOP_HINTSUM, imm:'h0000, length:'d00, operand1:MLDSA_HINT_R_0_BASE, operand2:MLDSA_NOP, operand3:MLDSA_NOP};
                //z ←NTT(z)
                MLDSA_VERIFY_NTT_Z          : data_o <= '{opcode:MLDSA_UOP_NTT, imm:'h0000, length:'d00, operand1:MLDSA_Z_0_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_Z_NTT_0_BASE};
                MLDSA_VERIFY_NTT_Z+ 1       : data_o <= '{opcode:MLDSA_UOP_NTT, imm:'h0000, length:'d00, operand1:MLDSA_Z_1_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_Z_NTT_1_BASE};
                MLDSA_VERIFY_NTT_Z+ 2       : data_o <= '{opcode:MLDSA_UOP_NTT, imm:'h0000, length:'d00, operand1:MLDSA_Z_2_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_Z_NTT_2_BASE};
                MLDSA_VERIFY_NTT_Z+ 3       : data_o <= '{opcode:MLDSA_UOP_NTT, imm:'h0000, length:'d00, operand1:MLDSA_Z_3_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_Z_NTT_3_BASE};
                MLDSA_VERIFY_NTT_Z+ 4       : data_o <= '{opcode:MLDSA_UOP_NTT, imm:'h0000, length:'d00, operand1:MLDSA_Z_4_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_Z_NTT_4_BASE};
                MLDSA_VERIFY_NTT_Z+ 5       : data_o <= '{opcode:MLDSA_UOP_NTT, imm:'h0000, length:'d00, operand1:MLDSA_Z_5_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_Z_NTT_5_BASE};
                MLDSA_VERIFY_NTT_Z+ 6       : data_o <= '{opcode:MLDSA_UOP_NTT, imm:'h0000, length:'d00, operand1:MLDSA_Z_6_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_Z_NTT_6_BASE};
                //Aˆ ←ExpandA(ρ) AND Aˆ ◦NTT(z)
                MLDSA_VERIFY_EXP_A          : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0000, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_0_BASE, operand3:MLDSA_AZ0_BASE};
                MLDSA_VERIFY_EXP_A+ 1       : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0001, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_1_BASE, operand3:MLDSA_AZ0_BASE};
                MLDSA_VERIFY_EXP_A+ 2       : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0002, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_2_BASE, operand3:MLDSA_AZ0_BASE};
                MLDSA_VERIFY_EXP_A+ 3       : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0003, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_3_BASE, operand3:MLDSA_AZ0_BASE};
                MLDSA_VERIFY_EXP_A+ 4       : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0004, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_4_BASE, operand3:MLDSA_AZ0_BASE};
                MLDSA_VERIFY_EXP_A+ 5       : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0005, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_5_BASE, operand3:MLDSA_AZ0_BASE};
                MLDSA_VERIFY_EXP_A+ 6       : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0006, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_6_BASE, operand3:MLDSA_AZ0_BASE};
                
                MLDSA_VERIFY_EXP_A+ 7       : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0100, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_0_BASE, operand3:MLDSA_AZ1_BASE};
                MLDSA_VERIFY_EXP_A+ 8       : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0101, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_1_BASE, operand3:MLDSA_AZ1_BASE};
                MLDSA_VERIFY_EXP_A+ 9       : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0102, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_2_BASE, operand3:MLDSA_AZ1_BASE};
                MLDSA_VERIFY_EXP_A+ 10      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0103, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_3_BASE, operand3:MLDSA_AZ1_BASE};
                MLDSA_VERIFY_EXP_A+ 11      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0104, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_4_BASE, operand3:MLDSA_AZ1_BASE};
                MLDSA_VERIFY_EXP_A+ 12      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0105, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_5_BASE, operand3:MLDSA_AZ1_BASE};
                MLDSA_VERIFY_EXP_A+ 13      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0106, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_6_BASE, operand3:MLDSA_AZ1_BASE};
                
                MLDSA_VERIFY_EXP_A+ 14      : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0200, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_0_BASE, operand3:MLDSA_AZ2_BASE};
                MLDSA_VERIFY_EXP_A+ 15      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0201, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_1_BASE, operand3:MLDSA_AZ2_BASE};
                MLDSA_VERIFY_EXP_A+ 16      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0202, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_2_BASE, operand3:MLDSA_AZ2_BASE};
                MLDSA_VERIFY_EXP_A+ 17      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0203, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_3_BASE, operand3:MLDSA_AZ2_BASE};
                MLDSA_VERIFY_EXP_A+ 18      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0204, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_4_BASE, operand3:MLDSA_AZ2_BASE};
                MLDSA_VERIFY_EXP_A+ 19      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0205, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_5_BASE, operand3:MLDSA_AZ2_BASE};
                MLDSA_VERIFY_EXP_A+ 20      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0206, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_6_BASE, operand3:MLDSA_AZ2_BASE};
                
                MLDSA_VERIFY_EXP_A+ 21      : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0300, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_0_BASE, operand3:MLDSA_AZ3_BASE};
                MLDSA_VERIFY_EXP_A+ 22      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0301, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_1_BASE, operand3:MLDSA_AZ3_BASE};
                MLDSA_VERIFY_EXP_A+ 23      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0302, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_2_BASE, operand3:MLDSA_AZ3_BASE};
                MLDSA_VERIFY_EXP_A+ 24      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0303, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_3_BASE, operand3:MLDSA_AZ3_BASE};
                MLDSA_VERIFY_EXP_A+ 25      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0304, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_4_BASE, operand3:MLDSA_AZ3_BASE};
                MLDSA_VERIFY_EXP_A+ 26      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0305, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_5_BASE, operand3:MLDSA_AZ3_BASE};
                MLDSA_VERIFY_EXP_A+ 27      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0306, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_6_BASE, operand3:MLDSA_AZ3_BASE};
                
                MLDSA_VERIFY_EXP_A+ 28      : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0400, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_0_BASE, operand3:MLDSA_AZ4_BASE};
                MLDSA_VERIFY_EXP_A+ 29      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0401, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_1_BASE, operand3:MLDSA_AZ4_BASE};
                MLDSA_VERIFY_EXP_A+ 30      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0402, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_2_BASE, operand3:MLDSA_AZ4_BASE};
                MLDSA_VERIFY_EXP_A+ 31      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0403, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_3_BASE, operand3:MLDSA_AZ4_BASE};
                MLDSA_VERIFY_EXP_A+ 32      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0404, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_4_BASE, operand3:MLDSA_AZ4_BASE};
                MLDSA_VERIFY_EXP_A+ 33      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0405, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_5_BASE, operand3:MLDSA_AZ4_BASE};
                MLDSA_VERIFY_EXP_A+ 34      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0406, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_6_BASE, operand3:MLDSA_AZ4_BASE};
            
                MLDSA_VERIFY_EXP_A+ 35      : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0500, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_0_BASE, operand3:MLDSA_AZ5_BASE};
                MLDSA_VERIFY_EXP_A+ 36      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0501, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_1_BASE, operand3:MLDSA_AZ5_BASE};
                MLDSA_VERIFY_EXP_A+ 37      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0502, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_2_BASE, operand3:MLDSA_AZ5_BASE};
                MLDSA_VERIFY_EXP_A+ 38      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0503, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_3_BASE, operand3:MLDSA_AZ5_BASE};
                MLDSA_VERIFY_EXP_A+ 39      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0504, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_4_BASE, operand3:MLDSA_AZ5_BASE};
                MLDSA_VERIFY_EXP_A+ 40      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0505, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_5_BASE, operand3:MLDSA_AZ5_BASE};
                MLDSA_VERIFY_EXP_A+ 41      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0506, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_6_BASE, operand3:MLDSA_AZ5_BASE};
                
                MLDSA_VERIFY_EXP_A+ 42      : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0600, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_0_BASE, operand3:MLDSA_AZ6_BASE};
                MLDSA_VERIFY_EXP_A+ 43      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0601, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_1_BASE, operand3:MLDSA_AZ6_BASE};
                MLDSA_VERIFY_EXP_A+ 44      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0602, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_2_BASE, operand3:MLDSA_AZ6_BASE};
                MLDSA_VERIFY_EXP_A+ 45      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0603, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_3_BASE, operand3:MLDSA_AZ6_BASE};
                MLDSA_VERIFY_EXP_A+ 46      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0604, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_4_BASE, operand3:MLDSA_AZ6_BASE};
                MLDSA_VERIFY_EXP_A+ 47      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0605, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_5_BASE, operand3:MLDSA_AZ6_BASE};
                MLDSA_VERIFY_EXP_A+ 48      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0606, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_6_BASE, operand3:MLDSA_AZ6_BASE};
            
                MLDSA_VERIFY_EXP_A+ 49      : data_o <= '{opcode:MLDSA_UOP_REJS_PWM,  imm:'h0700, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_0_BASE, operand3:MLDSA_AZ7_BASE};
                MLDSA_VERIFY_EXP_A+ 50      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0701, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_1_BASE, operand3:MLDSA_AZ7_BASE};
                MLDSA_VERIFY_EXP_A+ 51      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0702, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_2_BASE, operand3:MLDSA_AZ7_BASE};
                MLDSA_VERIFY_EXP_A+ 52      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0703, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_3_BASE, operand3:MLDSA_AZ7_BASE};
                MLDSA_VERIFY_EXP_A+ 53      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0704, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_4_BASE, operand3:MLDSA_AZ7_BASE};
                MLDSA_VERIFY_EXP_A+ 54      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0705, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_5_BASE, operand3:MLDSA_AZ7_BASE};
                MLDSA_VERIFY_EXP_A+ 55      : data_o <= '{opcode:MLDSA_UOP_REJS_PWMA, imm:'h0706, length:'d34, operand1:MLDSA_RHO_ID, operand2:MLDSA_Z_NTT_6_BASE, operand3:MLDSA_AZ7_BASE};
                
                //tr ←H(pk,512)
                MLDSA_VERIFY_H_TR           : data_o <= '{opcode:MLDSA_UOP_SHAKE256, imm:'h0000, length:PUBKEY_NUM_BYTES, operand1:MLDSA_PK_REG_ID, operand2:MLDSA_NOP, operand3:MLDSA_DEST_TR_REG_ID};
                //μ ←H(tr||M,512)
                MLDSA_VERIFY_H_MU           : data_o <= '{opcode:MLDSA_UOP_LD_SHAKE256, imm:'h0000, length:'d64, operand1:MLDSA_TR_ID, operand2:MLDSA_NOP, operand3:MLDSA_NOP};
                MLDSA_VERIFY_H_MU+ 1        : data_o <= '{opcode:MLDSA_UOP_SHAKE256, imm:'h0000, length:'d77, operand1:MLDSA_MSG_ID, operand2:MLDSA_NOP, operand3:MLDSA_DEST_MU_REG_ID};
                //c ←SampleInBall(c˜1)
                MLDSA_VERIFY_MAKE_C         : data_o <= '{opcode:MLDSA_UOP_SIB, imm:'h0000, length:'d64, operand1:MLDSA_SIG_C_REG_ID, operand2:MLDSA_NOP, operand3:MLDSA_NOP};
                //cˆ ←NTT(c)
                MLDSA_VERIFY_NTT_C          : data_o <= '{opcode:MLDSA_UOP_NTT, imm:'h0000, length:'d00, operand1:MLDSA_C_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_C_NTT_BASE};
                //t1 ←NTT(t1)
                MLDSA_VERIFY_NTT_T1          : data_o <= '{opcode:MLDSA_UOP_NTT, imm:'h0000, length:'d00, operand1:MLDSA_T0_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_T0_BASE};
                MLDSA_VERIFY_NTT_T1+ 1       : data_o <= '{opcode:MLDSA_UOP_NTT, imm:'h0000, length:'d00, operand1:MLDSA_T1_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_T1_BASE};
                MLDSA_VERIFY_NTT_T1+ 2       : data_o <= '{opcode:MLDSA_UOP_NTT, imm:'h0000, length:'d00, operand1:MLDSA_T2_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_T2_BASE};
                MLDSA_VERIFY_NTT_T1+ 3       : data_o <= '{opcode:MLDSA_UOP_NTT, imm:'h0000, length:'d00, operand1:MLDSA_T3_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_T3_BASE};
                MLDSA_VERIFY_NTT_T1+ 4       : data_o <= '{opcode:MLDSA_UOP_NTT, imm:'h0000, length:'d00, operand1:MLDSA_T4_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_T4_BASE};
                MLDSA_VERIFY_NTT_T1+ 5       : data_o <= '{opcode:MLDSA_UOP_NTT, imm:'h0000, length:'d00, operand1:MLDSA_T5_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_T5_BASE};
                MLDSA_VERIFY_NTT_T1+ 6       : data_o <= '{opcode:MLDSA_UOP_NTT, imm:'h0000, length:'d00, operand1:MLDSA_T6_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_T6_BASE};
                MLDSA_VERIFY_NTT_T1+ 7       : data_o <= '{opcode:MLDSA_UOP_NTT, imm:'h0000, length:'d00, operand1:MLDSA_T7_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_T7_BASE};
                //NTT(c) ◦NTT(t1)
                MLDSA_VERIFY_AZ_CT1          : data_o <= '{opcode:MLDSA_UOP_PWM, imm:'h0000, length:'d00, operand1:MLDSA_C_NTT_BASE, operand2:MLDSA_T0_BASE, operand3:MLDSA_CT1_0_BASE};
                MLDSA_VERIFY_AZ_CT1+ 1       : data_o <= '{opcode:MLDSA_UOP_PWM, imm:'h0000, length:'d00, operand1:MLDSA_C_NTT_BASE, operand2:MLDSA_T1_BASE, operand3:MLDSA_CT1_1_BASE};
                MLDSA_VERIFY_AZ_CT1+ 2       : data_o <= '{opcode:MLDSA_UOP_PWM, imm:'h0000, length:'d00, operand1:MLDSA_C_NTT_BASE, operand2:MLDSA_T2_BASE, operand3:MLDSA_CT1_2_BASE};
                MLDSA_VERIFY_AZ_CT1+ 3       : data_o <= '{opcode:MLDSA_UOP_PWM, imm:'h0000, length:'d00, operand1:MLDSA_C_NTT_BASE, operand2:MLDSA_T3_BASE, operand3:MLDSA_CT1_3_BASE};
                MLDSA_VERIFY_AZ_CT1+ 4       : data_o <= '{opcode:MLDSA_UOP_PWM, imm:'h0000, length:'d00, operand1:MLDSA_C_NTT_BASE, operand2:MLDSA_T4_BASE, operand3:MLDSA_CT1_4_BASE};
                MLDSA_VERIFY_AZ_CT1+ 5       : data_o <= '{opcode:MLDSA_UOP_PWM, imm:'h0000, length:'d00, operand1:MLDSA_C_NTT_BASE, operand2:MLDSA_T5_BASE, operand3:MLDSA_CT1_5_BASE};
                MLDSA_VERIFY_AZ_CT1+ 6       : data_o <= '{opcode:MLDSA_UOP_PWM, imm:'h0000, length:'d00, operand1:MLDSA_C_NTT_BASE, operand2:MLDSA_T6_BASE, operand3:MLDSA_CT1_6_BASE};
                MLDSA_VERIFY_AZ_CT1+ 7       : data_o <= '{opcode:MLDSA_UOP_PWM, imm:'h0000, length:'d00, operand1:MLDSA_C_NTT_BASE, operand2:MLDSA_T7_BASE, operand3:MLDSA_CT1_7_BASE};
                //A ˆ ◦NTT(z) −NTT(c) ◦NTT(t1)
                MLDSA_VERIFY_AZ_CT1+ 8       : data_o <= '{opcode:MLDSA_UOP_PWS, imm:'h0000, length:'d00, operand1:MLDSA_CT1_0_BASE, operand2:MLDSA_AZ0_BASE, operand3:MLDSA_AZ0_BASE};
                MLDSA_VERIFY_AZ_CT1+ 9       : data_o <= '{opcode:MLDSA_UOP_PWS, imm:'h0000, length:'d00, operand1:MLDSA_CT1_1_BASE, operand2:MLDSA_AZ1_BASE, operand3:MLDSA_AZ1_BASE};
                MLDSA_VERIFY_AZ_CT1+ 10      : data_o <= '{opcode:MLDSA_UOP_PWS, imm:'h0000, length:'d00, operand1:MLDSA_CT1_2_BASE, operand2:MLDSA_AZ2_BASE, operand3:MLDSA_AZ2_BASE};
                MLDSA_VERIFY_AZ_CT1+ 11      : data_o <= '{opcode:MLDSA_UOP_PWS, imm:'h0000, length:'d00, operand1:MLDSA_CT1_3_BASE, operand2:MLDSA_AZ3_BASE, operand3:MLDSA_AZ3_BASE};
                MLDSA_VERIFY_AZ_CT1+ 12      : data_o <= '{opcode:MLDSA_UOP_PWS, imm:'h0000, length:'d00, operand1:MLDSA_CT1_4_BASE, operand2:MLDSA_AZ4_BASE, operand3:MLDSA_AZ4_BASE};
                MLDSA_VERIFY_AZ_CT1+ 13      : data_o <= '{opcode:MLDSA_UOP_PWS, imm:'h0000, length:'d00, operand1:MLDSA_CT1_5_BASE, operand2:MLDSA_AZ5_BASE, operand3:MLDSA_AZ5_BASE};
                MLDSA_VERIFY_AZ_CT1+ 14      : data_o <= '{opcode:MLDSA_UOP_PWS, imm:'h0000, length:'d00, operand1:MLDSA_CT1_6_BASE, operand2:MLDSA_AZ6_BASE, operand3:MLDSA_AZ6_BASE};
                MLDSA_VERIFY_AZ_CT1+ 15      : data_o <= '{opcode:MLDSA_UOP_PWS, imm:'h0000, length:'d00, operand1:MLDSA_CT1_7_BASE, operand2:MLDSA_AZ7_BASE, operand3:MLDSA_AZ7_BASE};
                //w′ ←NTT-1(A ˆ ◦NTT(z) −NTT(c) ◦NTT(t1))
                MLDSA_VERIFY_MAKE_W          : data_o <= '{opcode:MLDSA_UOP_INTT, imm:'h0000, length:'d00, operand1:MLDSA_AZ0_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_W_0_BASE};
                MLDSA_VERIFY_MAKE_W+ 1       : data_o <= '{opcode:MLDSA_UOP_INTT, imm:'h0000, length:'d00, operand1:MLDSA_AZ1_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_W_1_BASE};
                MLDSA_VERIFY_MAKE_W+ 2       : data_o <= '{opcode:MLDSA_UOP_INTT, imm:'h0000, length:'d00, operand1:MLDSA_AZ2_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_W_2_BASE};
                MLDSA_VERIFY_MAKE_W+ 3       : data_o <= '{opcode:MLDSA_UOP_INTT, imm:'h0000, length:'d00, operand1:MLDSA_AZ3_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_W_3_BASE};
                MLDSA_VERIFY_MAKE_W+ 4       : data_o <= '{opcode:MLDSA_UOP_INTT, imm:'h0000, length:'d00, operand1:MLDSA_AZ4_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_W_4_BASE};
                MLDSA_VERIFY_MAKE_W+ 5       : data_o <= '{opcode:MLDSA_UOP_INTT, imm:'h0000, length:'d00, operand1:MLDSA_AZ5_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_W_5_BASE};
                MLDSA_VERIFY_MAKE_W+ 6       : data_o <= '{opcode:MLDSA_UOP_INTT, imm:'h0000, length:'d00, operand1:MLDSA_AZ6_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_W_6_BASE};
                MLDSA_VERIFY_MAKE_W+ 7       : data_o <= '{opcode:MLDSA_UOP_INTT, imm:'h0000, length:'d00, operand1:MLDSA_AZ7_BASE, operand2:MLDSA_TEMP0_BASE, operand3:MLDSA_W_7_BASE};
                //w ′ ←UseHint(h,w ′) AND c˜←H(μ||w1Encode(w1),2λ)
                MLDSA_VERIFY_MAKE_W+ 8       : data_o <= '{opcode:MLDSA_UOP_LD_SHAKE256, imm:'h0000, length:'d64, operand1:MLDSA_MU_ID, operand2:MLDSA_NOP, operand3:MLDSA_NOP};
                MLDSA_VERIFY_MAKE_W+ 9       : data_o <= '{opcode:MLDSA_UOP_USEHINT, imm:'h0000, length:'d00, operand1:MLDSA_W_0_BASE, operand2:MLDSA_HINT_R_0_BASE, operand3:MLDSA_NOP};
                MLDSA_VERIFY_MAKE_W+ 10      : data_o <= '{opcode:MLDSA_UOP_RUN_SHAKE256, imm:'h0000, length:'d00, operand1:MLDSA_NOP, operand2:MLDSA_NOP, operand3:MLDSA_DEST_VERIFY_RES_REG_ID};
                MLDSA_VERIFY_E               : data_o <= '{opcode:MLDSA_UOP_NOP, imm:'h0000, length:'d00, operand1:MLDSA_NOP, operand2:MLDSA_NOP, operand3:MLDSA_NOP};

                default :              data_o <= '{opcode: MLDSA_UOP_NOP, imm:'h0000, length:'d00, operand1:MLDSA_NOP, operand2:MLDSA_NOP, operand3:MLDSA_NOP};
            endcase 
        end
    end
end

endmodule