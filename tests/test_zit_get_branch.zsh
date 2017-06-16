#!/bin/zsh

setopt shwordsplit
SHUNIT_PARENT=$0

source ../zit.zsh

test_valid_https_without_branch() {
  local result=$(_zit-get-branch "https://github.com/m45t3r/zit")
  assertEquals "master" "${result}"
}

test_valid_https_with_branch() {
  local result=$(_zit-get-branch "https://github.com/m45t3r/zit#branch_name")
  assertEquals "branch_name" "${result}"
}

test_valid_git_without_branch() {
  local result=$(_zit-get-branch "git://github.com/m45t3r/zit")
  assertEquals "master" "${result}"
}

test_valid_git_with_branch() {
  local result=$(_zit-get-branch "git://github.com/m45t3r/zit#branch_name")
  assertEquals "branch_name" "${result}"
}

test_valid_ssh_without_branch() {
  local result=$(_zit-get-branch "git@github.com:m45t3r/zit.git")
  assertEquals "master" "${result}"
}

test_valid_ssh_with_branch() {
  local result=$(_zit-get-branch "git@github.com:m45t3r/zit.git#branch_name")
  assertEquals "branch_name" "${result}"
}

test_invalid_url() {
  # maybe in the case below it would be better to return an error or something
  local result=$(_zit-get-branch "https://github.com/m45t3r/zit#")
  assertNull "${result}"
}

source ./shunit2/src/shunit2
