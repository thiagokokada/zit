#!/usr/bin/env zsh

setopt shwordsplit
SHUNIT_PARENT=$0

source ../zit.zsh
source ./test_helpers.zsh

setUp() {
  ZIT_MODULES_PATH=$(mktemp -d)
  mkdir -p "${ZIT_MODULES_PATH}/a"
  mkdir -p "${ZIT_MODULES_PATH}/b"
  mock git
}

tearDown() {
  rm -rf "${ZIT_MODULES_PATH}"
}

test_upgrade_without_repos() {
  local result="$(zit-upgrade)"
  assertNull "${result}"
}

test_upgrade_with_repos() {
  ZIT_MODULES_UPGRADE=("${ZIT_MODULES_PATH}/a" "${ZIT_MODULES_PATH}/b")
  local result="$(zit-upgrade)"
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
