#!/bin/zsh

setopt shwordsplit
SHUNIT_PARENT=$0

source ../zit.zsh

setUp() {
  ZIT_MODULES_PATH="mocks"
}

test_loading_module_with_dot_zsh_param() {
  local result=$(zit-load "module" "dummy.zsh")
  assertEquals "Hello World!" "${result}"
}

test_loading_module_without_dot_zsh_param() {
  local result=$(zit-load "module")
  assertEquals "Hello World!" "${result}"
}

test_loading_module_with_glob_in_dot_zsh_param() {
  local result=$(zit-load "module" "*")
  assertEquals "Hello World!" "${result}"
}

test_missing_param_module_dir() {
  local result=$(zit-load)
  assertEquals "[zit] Missing argument: Module directory" "${result}"
}

source ./shunit2/src/shunit2
