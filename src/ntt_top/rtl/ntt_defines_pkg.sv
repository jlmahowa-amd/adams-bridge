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
//======================================================================
//
// ntt_defines_pkg.sv
// --------
// NTT interface parameters for the digital signature algorithm (DSA).
//
//
//======================================================================

`ifndef ABR_NTT_DEFINES
`define ABR_NTT_DEFINES

package ntt_defines_pkg;

localparam REG_SIZE = 24;
localparam NTT_REG_SIZE = REG_SIZE-1;
localparam MEM_ADDR_WIDTH = 15;
localparam MEM_DATA_WIDTH = 4*REG_SIZE;


// typedef enum logic [2:0] {ct, gs, pwm, pwa, pws} mode_t;
//TODO: tb has issue with enums in top level ports. For now, using this workaround
//Need to try something like bundling enable and mode into a struct to support enum.
localparam ct=0,
           gs=1,
           pwm=2,
           pwa=3,
           pws=4;
 
typedef logic [2:0] mode_t;

typedef enum logic [1:0] {RW_IDLE = 2'b00, RW_READ = 2'b01, RW_WRITE = 2'b10} mem_rw_mode_e;

typedef struct packed {
    mem_rw_mode_e rd_wr_en;
    logic [MEM_ADDR_WIDTH-1:0] addr;
} mem_if_t;

//NTT ports
typedef struct packed {
    logic [NTT_REG_SIZE-1:0] u00_i;
    logic [NTT_REG_SIZE-1:0] u01_i;
    logic [NTT_REG_SIZE-1:0] v00_i;
    logic [NTT_REG_SIZE-1:0] v01_i;
    logic [NTT_REG_SIZE-1:0] w00_i;
    logic [NTT_REG_SIZE-1:0] w01_i;
    logic [NTT_REG_SIZE-1:0] w10_i;
    logic [NTT_REG_SIZE-1:0] w11_i;
} bf_uvwi_t;

typedef struct packed {
    logic [NTT_REG_SIZE-1:0] u20_o;
    logic [NTT_REG_SIZE-1:0] u21_o;
    logic [NTT_REG_SIZE-1:0] v20_o;
    logic [NTT_REG_SIZE-1:0] v21_o;
} bf_uvo_t;

typedef struct packed {
    logic [MEM_ADDR_WIDTH-1:0] src_base_addr;
    logic [MEM_ADDR_WIDTH-1:0] interim_base_addr;
    logic [MEM_ADDR_WIDTH-1:0] dest_base_addr;
} ntt_mem_addr_t;

typedef struct packed {
    logic [MEM_ADDR_WIDTH-1:0] pw_base_addr_a;
    logic [MEM_ADDR_WIDTH-1:0] pw_base_addr_b;
    logic [MEM_ADDR_WIDTH-1:0] pw_base_addr_c;
} pwo_mem_addr_t;

//PWO ports
typedef struct packed {
    //input a
    logic [NTT_REG_SIZE-1:0] u0_i;
    logic [NTT_REG_SIZE-1:0] u1_i;
    logic [NTT_REG_SIZE-1:0] u2_i;
    logic [NTT_REG_SIZE-1:0] u3_i;
    //input b
    logic [NTT_REG_SIZE-1:0] v0_i;
    logic [NTT_REG_SIZE-1:0] v1_i;
    logic [NTT_REG_SIZE-1:0] v2_i;
    logic [NTT_REG_SIZE-1:0] v3_i;
    //accumulated input c (comes from dest mem)
    logic [NTT_REG_SIZE-1:0] w0_i;
    logic [NTT_REG_SIZE-1:0] w1_i;
    logic [NTT_REG_SIZE-1:0] w2_i;
    logic [NTT_REG_SIZE-1:0] w3_i;
} pwo_uvwi_t;

typedef struct packed {
    logic [NTT_REG_SIZE-1:0] uv0;
    logic [NTT_REG_SIZE-1:0] uv1;
    logic [NTT_REG_SIZE-1:0] uv2;
    logic [NTT_REG_SIZE-1:0] uv3;
} pwo_t;

typedef enum logic [2:0] {RD_IDLE, RD_STAGE, RD_BUF, RD_EXEC, EXEC_WAIT} ntt_read_state_t;
typedef enum logic [2:0] {WR_IDLE, WR_STAGE, WR_BUF, WR_MEM, WR_WAIT} ntt_write_state_t;

endpackage

`endif
