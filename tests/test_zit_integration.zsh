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

test_zit_in_zit_lo() {
  zit-in "https://github.com/junegunn/fzf" "fzf"
  assertTrue "${?}"
  zit-lo "fzf" "shell/completion.zsh"
  assertTrue "${?}"
  zit-lo "fzf" "shell/key-bindings.zsh"
  assertTrue "${?}"
}

test_zit_in_zit_lo_compat_with_other_shells() {
  zit-in "https://github.com/kennethreitz/autoenv" "autoenv"
  assertTrue "${?}"
  emulate sh -c 'zit-lo "autoenv" "activate.sh"'
  assertTrue "${?}"
}

test_zit_in_script_path() {
  zit-in "https://github.com/clvv/fasd" "fasd"
  assertTrue "${?}"
  export PATH="${ZIT_MODULES_PATH}/fasd:${PATH}"
  fasd
  assertTrue "${?}"
}

test_zit_in_zit_lo_with_branch() {
  zit-in "https://github.com/Eriner/zim#master" "zim"
  assertTrue "${?}"
  zit-lo "zim" "modules/directory/init.zsh"
  assertTrue "${?}"
  zit-lo "zim" "modules/environment/init.zsh"
  assertTrue "${?}"
  zit-lo "zim" "modules/git/init.zsh"
  assertTrue "${?}"
  zit-lo "zim" "modules/git-info/init.zsh"
  assertTrue "${?}"
  zit-lo "zim" "modules/history/init.zsh"
  assertTrue "${?}"
  zit-lo "zim" "modules/utility/init.zsh"
  assertTrue "${?}"
  zit-lo "zim" "modules/ssh/init.zsh"
  assertTrue "${?}"
  zit-lo "zim" "modules/syntax-highlighting/init.zsh"
  assertTrue "${?}"
  zit-lo "zim" "modules/history-substring-search/init.zsh"
  assertTrue "${?}"
  zit-lo "zim" "modules/prompt/init.zsh"
  assertTrue "${?}"
  zit-lo "zim" "modules/completion/init.zsh"
  assertTrue "${?}"
}

test_zit_il() {
  zit-il "https://github.com/sorin-ionescu/prezto#stashes" "prezto" "init.zsh"
  assertTrue "${?}"
}

test_zit_il_with_branch() {
  zit-il "https://github.com/zsh-users/zsh-autosuggestions#develop" \
    "zsh-autosuggestions" "zsh-autosuggestions.zsh"
  assertTrue "${?}"
}

test_zit_up() {
  zit-up
  assertTrue "${?}"
}

source ./shunit2/src/shunit2
