#!/usr/bin/env zsh

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
  assertTrue "zit-in 'https://github.com/junegunn/fzf' 'fzf'"
  assertTrue "zit-lo 'fzf' 'shell/completion.zsh'"
  assertTrue "zit-lo 'fzf' 'shell/key-bindings.zsh'"
}

test_zit_in_zit_lo_compat_with_other_shells() {
  assertTrue "zit-in 'https://github.com/kennethreitz/autoenv' 'autoenv'"
  assertTrue "emulate sh -c \"zit-load 'autoenv' 'activate.sh'\" "
}

test_zit_in_script_path() {
  assertTrue "zit-in 'https://github.com/clvv/fasd' 'fasd'"

  export PATH="${ZIT_MODULES_PATH}/fasd:${PATH}"
  assertTrue "fasd"
}

test_zit_in_zit_lo_with_branch() {
  assertTrue "zit-in 'https://github.com/Eriner/zim#zsh-5.0' 'zim'"
  assertTrue "zit-lo 'zim' 'modules/directory/init.zsh'"
  assertTrue "zit-lo 'zim' 'modules/environment/init.zsh'"
  assertTrue "zit-lo 'zim' 'modules/git/init.zsh'"
  assertTrue "zit-lo 'zim' 'modules/git-info/init.zsh'"
  assertTrue "zit-lo 'zim' 'modules/history/init.zsh'"
  assertTrue "zit-lo 'zim' 'modules/utility/init.zsh'"
  assertTrue "zit-lo 'zim' 'modules/ssh/init.zsh'"
  assertTrue "zit-lo 'zim' 'modules/syntax-highlighting/init.zsh'"
  assertTrue "zit-lo 'zim' 'modules/history-substring-search/init.zsh'"
  assertTrue "zit-lo 'zim' 'modules/prompt/init.zsh'"
  assertTrue "zit-lo 'zim' 'modules/completion/init.zsh'"
}

test_zit_il() {
  assertTrue "zit-il 'https://github.com/sorin-ionescu/prezto#stashes' 'prezto' 'init.zsh'"
}

test_zit_il_with_branch() {
  assertTrue "zit-il 'https://github.com/zsh-users/zsh-autosuggestions#develop' \
    'zsh-autosuggestions' 'zsh-autosuggestions.zsh'"
}

test_zit_up() {
  assertTrue "zit-up"
}

test_zit_rm() {
  # Needs to run without assert to export env variables to the sub-shells
  zit-in 'https://github.com/thiagokokada/zit' 'zit' &>/dev/null
  assertTrue "yes y | zit-rm 'zit'"
  assertTrue "[[ ! -d \"${ZIT_MODULES_PATH}/zit\" ]]"
}

source ./shunit2/src/shunit2
