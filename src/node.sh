function npm_is_not_installed {
  ! command -v "npm" >/dev/null 2>&1
}

if npm_is_not_installed; then
  exit
fi

declare -a packages=(
  "eslint"
  "eslint-config-adalab"
  "eslint"
  "eslint-plugin-promise"
)

function cache_slow_npm_list_command {
  echo "$(npm list --depth 0 --global)"
}

function is_not_installed_globally {
  ! echo "$1" | grep -i -q -w "$2"
}

function install_packages {
  npm_list="$(cache_slow_npm_list_command)"

  for package in "${packages[@]}"; do
    if is_not_installed_globally "$npm_list" "$package"; then
      npm install --global "$package"
    fi
  done
}

install_packages
