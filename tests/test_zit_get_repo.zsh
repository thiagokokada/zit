#!/bin/zsh

setopt shwordsplit
SHUNIT_PARENT=$0

source ../zit.zsh

test_valid_https_without_branch() {
  local result=$(_zit-get-repo "https://github.com/m45t3r/zit")
  assertEquals "https://github.com/m45t3r/zit" "${result}"
}

test_valid_https_with_branch() {
  local result=$(_zit-get-repo "https://github.com/m45t3r/zit#branch_name")
  assertEquals "https://github.com/m45t3r/zit" "${result}"
}

test_valid_git_without_branch() {
  local result=$(_zit-get-repo "git://github.com/m45t3r/zit")
  assertEquals "git://github.com/m45t3r/zit" "${result}"
}

test_valid_git_without_branch() {
  local result=$(_zit-get-repo "git://github.com/m45t3r/zit#branch_name")
  assertEquals "git://github.com/m45t3r/zit" "${result}"
}

test_valid_ssh_without_branch() {
  local result=$(_zit-get-repo "git@github.com:m45t3r/zit.git")
  assertEquals "git@github.com:m45t3r/zit.git" "${result}"
}

test_valid_ssh_with_branch() {
  local result=$(_zit-get-repo "git@github.com:m45t3r/zit.git#branch_name")
  assertEquals "git@github.com:m45t3r/zit.git" "${result}"
}

source ./shunit2/src/shunit2
