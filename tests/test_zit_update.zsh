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
  INITIAL_DIRECTORY="${PWD}"
  zit-install-load "${REPO_URL}" "zit" &> /dev/null
}

tearDown() {
  cd "${INITIAL_DIRECTORY}"
  rm -rf "tmp"
}

test_update() {
  local result=$(zit-update)
  local expect=$(cat << EOF
Updating tmp/zit
Already up-to-date.
EOF
  )
  assertEquals "${expect}" "${result}"
}

source ./shunit2/src/shunit2
