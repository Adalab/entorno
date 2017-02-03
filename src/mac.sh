declare -a binaries=(
  node
  git
)

declare -a casks=(
  atom
  sublime-text
  meld
)

function install_cli_tools {
  echo "Installing XCode command line tools..."
  xcode-select --install
}

function install_homebrew {
  echo "Installing Homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

function binary_is_not_installed {
  ! command -v "$1" >/dev/null 2>&1
}

function install_binaries {
  echo "Installing required binaries..."

  for binary in "${binaries[@]}"; do
    if binary_is_not_installed "$binary"; then
      brew install binary
    fi
  done
}

function install_homebrew_cask {
  echo "Installing Homebrew Cask..."
  brew tap caskroom/cask
}

function replace_dashes_by_spaces {
  echo "${1//-/ }"
}

function app_is_not_installed {
  ! ls /Applications/ | grep -i -q "$1" && ! ls "$HOME/Applications/" | grep -i -q "$1"
}

function install_apps {
  echo "Installing applications..."
  for cask in "${casks[@]}"; do
    app="$(replace_dashes_by_spaces $cask)"

    if app_is_not_installed "$app"; then
      echo "Installing $app..."
      brew cask install "$cask"
    fi
  done
}

function osx_main {
  install_cli_tools &&
  install_homebrew &&
  install_binaries &&
  install_homebrew_cask &&
  install_apps ||
  echo "Error trying to install OSX binaries and applications"
}
