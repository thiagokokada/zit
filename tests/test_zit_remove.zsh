#!/usr/bin/env zsh

setopt shwordsplit
SHUNIT_PARENT=$0

source ../zit.zsh

setUp() {
    ZIT_MODULES_PATH=$(mktemp -d)
    mkdir -p "${ZIT_MODULES_PATH}/a"
    mkdir -p "${ZIT_MODULES_PATH}/b"
    ZIT_MODULES_UPGRADE=("${ZIT_MODULES_PATH}/a" "${ZIT_MODULES_PATH}/b")
}

tearDown() {
    rm -rf "${ZIT_MODULES_PATH}"
}

test_remove_directory() {
    local result="$(yes y | zit-remove a)"
    assertEquals "Really delete module a? (y/n) " "${result}"
    assertTrue "[[ ! -d \"${ZIT_MODULES_PATH}/a\" ]]"
}

test_do_not_remove_directory() {
    local result="$(yes n | zit-remove b)"
    assertEquals "Really delete module b? (y/n) " "${result}"
    assertTrue "[[ -d \"${ZIT_MODULES_PATH}/b\" ]]"
}

test_remove_inexistent_directory() {
    local result="$(zit-remove c)"
    assertEquals "No module c is installed." "${result}"
}

source ./shunit2/src/shunit2
