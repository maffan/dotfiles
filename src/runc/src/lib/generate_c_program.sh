#!/bin/bash
## Add any function here that is needed in more than one parts of your
## application, or that you otherwise wish to extract from the main function
## scripts.
##
## Note that code here should be wrapped inside bash functions, and it is
## recommended to have a separate file for each function.
##
## Subdirectories will also be scanned for *.sh, so you have no reason not
## to organize your code neatly.
##
generate_c_program() {
  local code="${1?No code}"
  cat <<-EOF
    #include <stdio.h>
    #include <stdlib.h>
EOF
  for lib in "${C_LIB_DIR?No c_lib dir}"/*.c; do
    sed -n '/\bHEADER_START/,/\bHEADER_END/p' "$lib"
  done
  for lib in "${C_LIB_DIR?No c_lib dir}"/*.c; do
    sed -n '/\bFUNCTIONS_START/,/\bFUNCTIONS_END/p' "$lib"
  done
  cat <<-EOF
    int main(int argc, char *argv[])
    {
EOF
  for lib in "${C_LIB_DIR?No c_lib dir}"/*.c; do
    sed -n '/\bMAIN_CODE_START/,/\bMAIN_CODE_END/p' "$lib"
  done
  cat <<-EOF
      $code
    }
EOF
}
