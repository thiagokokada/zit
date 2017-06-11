# Zit - minimal plugin manager for ZSH

# store all loaded modules to paths
export -a ZIT_MODULES_LOADED
# set variable below to change zit modules path
if [[ -z "${ZIT_MODULES_PATH}" ]]; then
  export ZIT_MODULES_PATH="${ZDOTDIR:-${HOME}}"
fi

# https://github.com/m45t3r/zit#branch -> https://github.com/m45t3r/zit
_zit-get-repo() {
  eval "${1}=${2%'#'*}"
}

# https://github.com/m45t3r/zit -> master
# https://github.com/m45t3r/zit#branch -> branch
_zit-get-branch() {
  local branch="${2#*'#'}"
  if [[ "${branch}" = "${2}" ]]; then
    eval "${1}=master"
  else
    eval "${1}=${branch}"
  fi
}

# loader
zit-load() {
  local module_dir="${ZIT_MODULES_PATH}/${1}"
  local dot_zsh="${2:-*.zsh}"
  # load module in zsh
  eval source "${module_dir}/${dot_zsh}"
  # added to global dir array for updater
  ZIT_MODULES_LOADED+=("${module_dir}")
}

# installer
zit-install() {
  local git_repo; _zit-get-repo git_repo "${1}"
  local git_branch; _zit-get-branch git_branch "${1}"
  local module_dir="${ZIT_MODULES_PATH}/${2}"

  # clone module
  if [[ ! -d "${module_dir}" ]]; then
    echo "Installing ${module_dir}"
    git clone --recursive "${git_repo}" -b "${git_branch}" "${module_dir}"
    echo
  fi
}

# do both above in one step
zit-install-load() {
  local git_repo="${1}"
  local module_dir="${2}"
  local dot_zsh="${3:-*.zsh}"

  zit-install "${git_repo}" "${module_dir}"
  zit-load "${module_dir}" "${dot_zsh}"
}

# updater
zit-update() {
  for module_dir in ${ZIT_MODULES_LOADED}; do
    pushd "${module_dir}"
    echo "Updating ${module_dir}"
    git pull --rebase
    echo
    popd
  done
}

alias zit-in="zit-install"
alias zit-lo="zit-load"
alias zit-il="zit-install-load"
alias zit-up="zit-update"

# vim: ft=zsh
