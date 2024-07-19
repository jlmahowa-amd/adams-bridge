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
// skdecode_defines_pkg.sv
// --------
// Skdecode parameters for Dilithium
//======================================================================

`ifndef ABR_SKDECODE_DEFINES
`define ABR_SKDECODE_DEFINES

package skdecode_defines_pkg;
    import ntt_defines_pkg::*;

    parameter KEY_MEM_ADDR_WIDTH = 15;

    typedef enum logic [2:0] {SKDEC_RD_IDLE, SKDEC_RD_STAGE, SKDEC_RD_S1, SKDEC_RD_S2, SKDEC_RD_T0} skdec_read_state_e;
    typedef enum logic [2:0] {SKDEC_WR_IDLE, SKDEC_WR_STAGE, SKDEC_WR_S1, SKDEC_WR_S2, SKDEC_WR_T0} skdec_write_state_e;

    typedef struct packed {
        mem_rw_mode_e rd_wr_en;
        logic [KEY_MEM_ADDR_WIDTH-1:0] addr;
    } key_mem_if_t;

endpackage

`endif