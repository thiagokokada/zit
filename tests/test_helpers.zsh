mock() {
  eval "${1}() { echo "${1} '${*}'" }"
}
