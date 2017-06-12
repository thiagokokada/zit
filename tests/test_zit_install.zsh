#!/bin/zsh

setopt shwordsplit
SHUNIT_PARENT=$0

source ../zit.zsh

setUp() {
  REPO_URL="https://github.com/m45t3r/zit"
  ZIT_MODULES_PATH=$(mktemp -d)
  # mock git
  git() { echo "git ${@}"; mkdir -p "${ZIT_MODULES_PATH}/zit" }
}

tearDown() {
  rm -rf "${ZIT_MODULES_PATH}"
}

test_install_without_branch() {
  local result=$(zit-install "${REPO_URL}" "zit")
  local expect=$(cat <<EOF
Installing ${ZIT_MODULES_PATH}/zit
git clone --recursive ${REPO_URL} -b master ${ZIT_MODULES_PATH}/zit
EOF
  )
  assertEquals "${expect}" "${result}"
}

test_install_with_branch() {
  local result=$(zit-install "${REPO_URL}#branch_name" "zit")
  local expect=$(cat <<EOF
Installing ${ZIT_MODULES_PATH}/zit
git clone --recursive ${REPO_URL} -b branch_name ${ZIT_MODULES_PATH}/zit
EOF
  )
}

test_install_multiple_times() {
  zit-install "${REPO_URL}" "zit" &> /dev/null
  local result=$(zit-install "${REPO_URL}" "zit")
  assertNull "${result}"
}

source ./shunit2/src/shunit2
