# Zit - minimal plugin manager for ZSH

# store all loaded modules to paths
export -Ua ZIT_MODULES_LOADED
# set variable below to change zit modules path
if [[ -z "${ZIT_MODULES_PATH}" ]]; then
  export ZIT_MODULES_PATH="${ZDOTDIR:-${HOME}}"
fi

# https://github.com/m45t3r/zit#branch -> https://github.com/m45t3r/zit
_zit-get-repo() {
  printf "%s\n" "${1%'#'*}"
}

# https://github.com/m45t3r/zit -> master
# https://github.com/m45t3r/zit#branch -> branch
_zit-get-branch() {
  local branch="${1#*'#'}"
  if [[ -z "${branch}" || "${branch}" == "${1}" ]]; then
    printf "master\n"
  else
    printf "%s\n" "${branch}"
  fi
}

_zit-param-validation() {
  local name="${1}"
  local param="${2}"
  if [[ -z "${param}" ]]; then
    printf "[zit] Missing argument: %s\n" "${name}"
    return 1
  fi
  return 0
}

# loader
zit-load() {
  _zit-param-validation "Module directory" "${1}" || return 1
  _zit-param-validation ".zsh file" "${2}" || return 1

  local module_dir="${ZIT_MODULES_PATH}/${1}"
  local dot_zsh="${2}"

  # shellcheck source=/dev/null
  source "${module_dir}/${dot_zsh}" || return 1
  # added to global dir array for updater
  ZIT_MODULES_LOADED+=("${module_dir}")
}

# installer
zit-install() {
  _zit-param-validation "Git repo" "${1}" || return 1
  _zit-param-validation "Module directory" "${2}" || return 1

  local git_repo; git_repo="$(_zit-get-repo "${1}")"
  local git_branch; git_branch="$(_zit-get-branch "${1}")"
  local module_dir="${ZIT_MODULES_PATH}/${2}"

  # clone module
  if [[ ! -d "${module_dir}" ]]; then
    printf "Installing %s\n" "${module_dir}"
    git clone --recurse-submodules "${git_repo}" -b "${git_branch}" "${module_dir}"
    printf "\n"
  fi
  # added to global dir array for updater
  ZIT_MODULES_LOADED+=("${module_dir}")
}

# do both above in one step
zit-install-load() {
  _zit-param-validation "Git repo" "${1}" || return 1
  _zit-param-validation "Module directory" "${2}" || return 1
  _zit-param-validation ".zsh file" "${3}" || return 1

  local git_repo="${1}"
  local module_dir="${2}"
  local dot_zsh="${3}"

  zit-install "${git_repo}" "${module_dir}"
  zit-load "${module_dir}" "${dot_zsh}"
}

# updater
zit-update() {
  local module_dir

  for module_dir in "${ZIT_MODULES_LOADED[@]}"; do
    pushd "${module_dir}" > /dev/null || continue
    printf "Updating %s\n" "${module_dir}"
    git pull
    printf "\n"
    popd > /dev/null || continue
  done
}

alias zit-in="zit-install"
alias zit-lo="zit-load"
alias zit-il="zit-install-load"
alias zit-up="zit-update"

# vim: ft=zsh
