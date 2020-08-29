#!/usr/bin/env zsh

setopt shwordsplit
SHUNIT_PARENT=$0

source ../zit.zsh
source ./test_helpers.zsh

setUp() {
  REPO_URL="https://github.com/thiagokokada/zit"
  # mocking real zit functions
  mock zit-install
  mock zit-load
}

test_install_load() {
  local result="$(zit-install-load "${REPO_URL}" "zit" "zit.zsh")"
  local expect="$(cat <<EOF
zit-install https://github.com/thiagokokada/zit zit
zit-load zit zit.zsh
EOF
  )"
  assertEquals "${expect}" "${result}"
}

test_missing_param_git_repo() {
  local result="$(zit-install-load)"
  assertEquals "[zit] Missing argument: Git repo" "${result}"
}

test_missing_param_module_dir() {
  local result="$(zit-install-load "${REPO_URL}")"
  assertEquals "[zit] Missing argument: Module directory" "${result}"
}

test_missing_param_dot_zsh() {
  local result="$(zit-install-load "${REPO_URL}" "zit")"
  assertEquals "[zit] Missing argument: .zsh file" "${result}"
}

source ./shunit2/src/shunit2
