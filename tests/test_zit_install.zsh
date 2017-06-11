#!/bin/zsh

setopt shwordsplit
SHUNIT_PARENT=$0

source ../zit.zsh

# For tests in remote repository
REPO_URL="https://github.com/m45t3r/zit"
# Local tests using this own git repository
# REPO_URL="../"

setUp() {
  export LANG=C
  ZIT_MODULES_PATH="tmp"
  INITIAL_DIRECTORY=${PWD}
}

tearDown() {
  cd "$INITIAL_DIRECTORY"
  rm -rf "tmp"
}

test_install_without_branch() {
  zit-install "${REPO_URL}" "zit" &> /dev/null
  cd "${ZIT_MODULES_PATH}/zit"
  git branch | grep "* master" &> /dev/null
  assertTrue "${?}"
}

test_install_with_branch() {
  zit-install "${REPO_URL}#tests" "zit" &> /dev/null
  cd "${ZIT_MODULES_PATH}/zit"
  git branch | grep "* tests" &> /dev/null
  assertTrue "${?}"
}

test_install_multiple_times() {
  zit-install "${REPO_URL}" "zit" &> /dev/null
  local result=$(zit-install "${REPO_URL}" "zit")
  assertNull "${result}"
}

source ./shunit2/src/shunit2
