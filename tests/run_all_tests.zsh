#!/bin/zsh

RETURN_CODE=0

run_test() {
  printf "Running test: %s\n\n" "${1}"
  zsh "./${1}.zsh"
  local rc="${?}"
  [[ "${rc}" != 0 ]] && RETURN_CODE="${rc}"
  printf "\n"
}

git --version
zsh --version
printf "\n"

if (( $+commands[shellcheck] )); then
  printf "Running ShellCheck\n"
  shellcheck --version
  shellcheck -s bash "../zit.zsh"
  printf "\n"
fi

run_test test_zit_aliases
run_test test_zit_install
run_test test_zit_install_load
run_test test_zit_load
run_test test_zit_update
run_test test_zit_integration

return "${RETURN_CODE}"
