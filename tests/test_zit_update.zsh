#!/bin/zsh

setopt shwordsplit
SHUNIT_PARENT=$0

source ../zit.zsh

setUp() {
  ZIT_MODULES_PATH=$(mktemp -d)
  # mock git
  export PATH="${PWD}/mocks/bin:${PATH}"
  mkdir -p "${ZIT_MODULES_PATH}/a"
  mkdir -p "${ZIT_MODULES_PATH}/b"
}

tearDown() {
  rm -rf "${ZIT_MODULES_PATH}"
}

test_update_without_repos() {
  local result="$(zit-update)"
  assertNull "${result}"
}

test_update_with_repos() {
  ZIT_MODULES_UPGRADE=("${ZIT_MODULES_PATH}/a" "${ZIT_MODULES_PATH}/b")
  local result="$(zit-update)"
  local expect="$(cat << EOF
Updating ${ZIT_MODULES_PATH}/a
git pull

Updating ${ZIT_MODULES_PATH}/b
git pull
EOF
  )"
  assertEquals "${expect}" "${result}"
}

source ./shunit2/src/shunit2
