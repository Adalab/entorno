function is_osx {
  [[ "$OSTYPE" =~ ^darwin ]] || return 1
}

function is_ubuntu {
  [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1
}

if [[ is_osx ]]; then
  echo "Running Mac OS installation..."
  source osx.sh
elif [[ is_ubuntu ]]; then
  echo "Running Ubuntu installation..."

else
  echo "This machine is using a system different from Ubuntu or Mac OS. None of the tools has been installed"
  exit 1
fi
