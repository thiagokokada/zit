#!/usr/bin/env zsh

setopt shwordsplit
SHUNIT_PARENT=$0

source ../zit.zsh

setUp() {
  REPO_URL="https://github.com/thiagokokada/zit"
  ZIT_MODULES_PATH=$(mktemp -d)
  # mock git
  export PATH="${PWD}/mocks/bin:${PATH}"
}

tearDown() {
  rm -rf "${ZIT_MODULES_PATH}"
}

test_install_without_branch() {
  local result="$(zit-install "${REPO_URL}" "zit";
                  echo "ZIT_MODULES_UPGRADE: ${ZIT_MODULES_UPGRADE}")"
  local expect="$(cat <<EOF
Installing ${ZIT_MODULES_PATH}/zit
git clone --recurse-submodules ${REPO_URL} -b master ${ZIT_MODULES_PATH}/zit

ZIT_MODULES_UPGRADE: ${ZIT_MODULES_PATH}/zit
EOF
  )"
  assertEquals "${expect}" "${result}"
}

test_install_with_hash() {
  local result="$(zit-install "${REPO_URL}#" "zit";
                  echo "ZIT_MODULES_UPGRADE: ${ZIT_MODULES_UPGRADE}")"
  local expect="$(cat <<EOF
Installing ${ZIT_MODULES_PATH}/zit
git clone --recurse-submodules ${REPO_URL} -b master ${ZIT_MODULES_PATH}/zit

ZIT_MODULES_UPGRADE: ${ZIT_MODULES_PATH}/zit
EOF
  )"
  assertEquals "${expect}" "${result}"
}

test_install_with_branch() {
  local result="$(zit-install "${REPO_URL}#branch_name" "zit";
                  echo "ZIT_MODULES_UPGRADE: ${ZIT_MODULES_UPGRADE}")"
  local expect="$(cat <<EOF
Installing ${ZIT_MODULES_PATH}/zit
git clone --recurse-submodules ${REPO_URL} -b branch_name ${ZIT_MODULES_PATH}/zit

ZIT_MODULES_UPGRADE: ${ZIT_MODULES_PATH}/zit
EOF
  )"
  assertEquals "${expect}" "${result}"
}

test_install_without_upgrade() {
  local result="$(ZIT_DISABLE_UPGRADE=1 zit-install "${REPO_URL}" "zit";
                  echo "ZIT_MODULES_UPGRADE: ${ZIT_MODULES_UPGRADE}")"
  local expect="$(cat <<EOF
Installing ${ZIT_MODULES_PATH}/zit
git clone --recurse-submodules ${REPO_URL} -b master ${ZIT_MODULES_PATH}/zit

ZIT_MODULES_UPGRADE: 
EOF
  )"
  assertEquals "${expect}" "${result}"
}

test_install_with_upgrade_forced() {
  local result="$(ZIT_DISABLE_UPGRADE=1
                  ZIT_DISABLE_UPGRADE= zit-install "${REPO_URL}" "zit";
                  echo "ZIT_MODULES_UPGRADE: ${ZIT_MODULES_UPGRADE}")"
  local expect="$(cat <<EOF
Installing ${ZIT_MODULES_PATH}/zit
git clone --recurse-submodules ${REPO_URL} -b master ${ZIT_MODULES_PATH}/zit

ZIT_MODULES_UPGRADE: ${ZIT_MODULES_PATH}/zit
EOF
  )"
  assertEquals "${expect}" "${result}"
}

test_install_non_standard_directory() {
  local tmpdir="$(mktemp -d)"
  local result="$(ZIT_MODULES_PATH="${tmpdir}" zit-install "${REPO_URL}" "zit";
                  echo "ZIT_MODULES_UPGRADE: ${ZIT_MODULES_UPGRADE}")"
  local expect="$(cat <<EOF
Installing ${tmpdir}/zit
git clone --recurse-submodules ${REPO_URL} -b master ${tmpdir}/zit

ZIT_MODULES_UPGRADE: ${tmpdir}/zit
EOF
  )"
  assertEquals "${expect}" "${result}"
}

test_install_multiple_times() {
  mkdir -p "${ZIT_MODULES_PATH}/zit" # simulate another zit-in call
  local result="$(zit-install "${REPO_URL}" "zit")"
  assertNull "${result}"
}

test_missing_param_git_repo() {
  local result="$(zit-install)"
  assertEquals "[zit] Missing argument: Git repo" "${result}"
}

test_missing_param_module_dir() {
  local result="$(zit-install "https://github.com/thiagokokada/zit")"
  assertEquals "[zit] Missing argument: Module directory" "${result}"
}

source ./shunit2/src/shunit2
