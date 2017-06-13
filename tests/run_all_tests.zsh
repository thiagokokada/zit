#!/bin/zsh

RETURN_CODE=0

run_test() {
  printf "Running test: %s\n\n" "${1}"
  zsh "./${1}.zsh"
  local rc="${?}"
  [[ "${rc}" != 0 ]] && RETURN_CODE="${rc}"
  printf "\n"
}

printf "ZSH VERSION=%s\n\n" "${ZSH_VERSION}"

shellcheck -s bash "../zit.zsh"
run_test test_zit_aliases
run_test test_zit_get_branch
run_test test_zit_get_repo
run_test test_zit_install
run_test test_zit_install_load
run_test test_zit_load
run_test test_zit_update
run_test test_zit_integration

return "${RETURN_CODE}"
