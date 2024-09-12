// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

`ifndef ABR_PRIM_FLOP_MACROS_SV
`define ABR_PRIM_FLOP_MACROS_SV

/////////////////////////////////////
// Default Values for Macros below //
/////////////////////////////////////

`define ABR_PRIM_FLOP_CLK clk_i
`define ABR_PRIM_FLOP_RST rst_b
`define ABR_PRIM_FLOP_RESVAL '0

/////////////////////
// Register Macros //
/////////////////////

// TODO: define other variations of register macros so that they can be used throughout all designs
// to make the code more concise.

// Register with asynchronous reset.
`define ABR_PRIM_FLOP_A(__d, __q, __resval = `ABR_PRIM_FLOP_RESVAL, __clk = `ABR_PRIM_FLOP_CLK, __rst_n = `ABR_PRIM_FLOP_RST) \
  always_ff @(posedge __clk or negedge __rst_n) begin \
    if (!__rst_n) begin                               \
      __q <= __resval;                                \
    end else begin                                    \
      __q <= __d;                                     \
    end                                               \
  end

///////////////////////////
// Macro for Sparse FSMs //
///////////////////////////

// Simulation tools typically infer FSMs and report coverage for these separately. However, tools
// like Xcelium and VCS seem to have problems inferring FSMs if the state register is not coded in
// a behavioral always_ff block in the same hierarchy. To that end, this uses a modified variant
// with a second behavioral register definition for RTL simulations so that FSMs can be inferred.
// Note that in this variant, the __q output is disconnected from abr_prim_sparse_fsm_flop and attached
// to the behavioral flop. An assertion is added to ensure equivalence between the
// abr_prim_sparse_fsm_flop output and the behavioral flop output in that case.
`define ABR_PRIM_FLOP_SPARSE_FSM(__name, __d, __q, __type, __resval = `ABR_PRIM_FLOP_RESVAL, __clk = `ABR_PRIM_FLOP_CLK, __rst_n = `ABR_PRIM_FLOP_RST, __alert_trigger_sva_en = 1) \
  `ifdef ABR_SIMULATION                                   \
    abr_prim_sparse_fsm_flop #(                           \
      .StateEnumT(__type),                            \
      .Width($bits(__type)),                          \
      .ResetValue($bits(__type)'(__resval)),          \
      .EnableAlertTriggerSVA(__alert_trigger_sva_en), \
      .CustomForceName(`ABR_PRIM_STRINGIFY(__q))          \
    ) __name (                                        \
      .clk_i   ( __clk   ),                           \
      .rst_b  ( __rst_n ),                           \
      .state_i ( __d     ),                           \
      .state_o (         )                            \
    );                                                \
    `ABR_PRIM_FLOP_A(__d, __q, __resval, __clk, __rst_n)  \
    `ABR_ASSERT(``__name``_A, __q === ``__name``.state_o) \
  `else                                               \
    abr_prim_sparse_fsm_flop #(                           \
      .StateEnumT(__type),                            \
      .Width($bits(__type)),                          \
      .ResetValue($bits(__type)'(__resval)),          \
      .EnableAlertTriggerSVA(__alert_trigger_sva_en)  \
    ) __name (                                        \
      .clk_i   ( __clk   ),                           \
      .rst_b  ( __rst_n ),                           \
      .state_i ( __d     ),                           \
      .state_o ( __q     )                            \
    );                                                \
  `endif

`endif // PRIM_FLOP_MACROS_SV
