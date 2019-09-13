#!/usr/bin/env zsh

setopt shwordsplit
SHUNIT_PARENT=$0

source ../zit.zsh
source ./test_helpers.zsh

setUp() {
  # mocking real zit functions
  mock zit-install
  mock zit-load
  mock zit-install-load
  mock zit-upgrade
  mock zit-remove
}

test_alias_zit_in() {
  local result="$(zit-in)"
  assertEquals "zit-install" "${result}"
}

test_alias_zit_lo() {
  local result="$(zit-lo)"
  assertEquals "zit-load" "${result}"
}

test_alias_zit_il() {
  local result="$(zit-il)"
  assertEquals "zit-install-load" "${result}"
}

test_alias_zit_up() {
  local result="$(zit-up)"
  assertEquals "zit-upgrade" "${result}"
}

test_alias_zit_update() {
  local result="$(zit-update)"
  assertEquals "zit-upgrade" "${result}"
}

test_alias_zit_rm() {
    local result="$(zit-rm)"
    assertEquals "zit-remove" "${result}"
}

source ./shunit2/src/shunit2
