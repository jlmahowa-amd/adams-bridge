//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// DESCRIPTION: This package contains all tests currently written for
//     the simulation project.  Once compiled, any test can be selected
//     from the vsim command line using +UVM_TESTNAME=yourTestNameHere
//
// CONTAINS:
//     -<test_top>
//     -<example_derived_test>
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

package mldsa_tests_pkg;

   import uvm_pkg::*;
   import uvmf_base_pkg::*;
   import mldsa_parameters_pkg::*;
   import mldsa_env_pkg::*;
   import mldsa_sequences_pkg::*;
   import qvip_ahb_lite_slave_pkg::*;
   import QUESTA_MVC::*;
   import qvip_utils_pkg::*;
   import mvc_pkg::*;
   import mgc_ahb_v2_0_pkg::*;


   `include "uvm_macros.svh"

  // pragma uvmf custom package_imports_additional begin 
  // pragma uvmf custom package_imports_additional end

   `include "src/test_top.svh"
   `include "src/register_test.svh"
   `include "src/example_derived_test.svh"
   `include "src/ML_DSA_randomized_key_gen_test.svh"
   `include "src/ML_DSA_randomized_sign_gen_test.svh"
   `include "src/ML_DSA_randomized_all_test.svh"
   `include "src/ML_DSA_randomized_verif_test.svh"

  // pragma uvmf custom package_item_additional begin
  // UVMF_CHANGE_ME : When adding new tests to the src directory
  //    be sure to add the test file here so that it will be
  //    compiled as part of the test package.  Be sure to place
  //    the new test after any base tests of the new test.
  // pragma uvmf custom package_item_additional end

endpackage

// pragma uvmf custom external begin
// pragma uvmf custom external end

