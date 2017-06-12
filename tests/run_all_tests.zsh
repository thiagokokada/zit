#!/bin/zsh

set -eu

run_test() {
  echo "Running test: ${1}"
  zsh "./${1}.zsh"
  echo
}

run_test test_zit_aliases
run_test test_zit_get_branch
run_test test_zit_get_repo
run_test test_zit_install
run_test test_zit_install_load
run_test test_zit_load
run_test test_zit_update
run_test test_zit_integration
