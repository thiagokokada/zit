#!/bin/zsh

setopt shwordsplit
SHUNIT_PARENT=$0

source ../zit.zsh

oneTimeSetUp() {
  ZIT_MODULES_PATH=$(mktemp -d)
}

oneTimeTearDown() {
  rm -rf "${ZIT_MODULES_PATH}"
}

test_zit_in_zit_lo_with_dotzsh() {
  zit-in "https://github.com/junegunn/fzf" "fzf"
  assertTrue "${?}"
  zit-lo "fzf" "shell/*.zsh"
  assertTrue "${?}"
}

test_zit_in_zit_lo_without_dotzsh() {
  zit-in "https://github.com/sorin-ionescu/prezto" "prezto"
  assertTrue "${?}"
  zit-lo "prezto"
  assertTrue "${?}"
}

test_zit_il_without_dotzsh() {
  zit-il "https://github.com/Eriner/zim" "zim"
  assertTrue "${?}"
}

test_zit_il_with_dotzsh() {
  zit-il "https://github.com/zsh-users/zsh-autosuggestions" \
    "zsh-autosuggestions" "zsh-autosuggestions.zsh"
  assertTrue "${?}"
}

test_zit_up() {
  zit-up
  assertTrue "${?}"
}

source ./shunit2/src/shunit2
