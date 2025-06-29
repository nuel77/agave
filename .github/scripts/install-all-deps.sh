#!/usr/bin/env bash

set -e

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

os_name="$1"

# shellcheck source=.github/scripts/install-openssl.sh
source "$here/install-openssl.sh" "$os_name"
# shellcheck source=.github/scripts/install-proto.sh
source "$here/install-proto.sh" "$os_name"

case "$os_name" in
"Windows") ;;
"macOS")
  brew install llvm
  LIBCLANG_PATH="$(brew --prefix llvm)/lib"
  export LIBCLANG_PATH
  ;;
"Linux")
  if grep "Alpine" /etc/os-release ; then
    apk update
    apk add \
      build-base \
      clang-libclang \
      eudev-dev \
      hidapi-dev \
      linux-headers \
      llvm-dev \
      musl-dev \
      perl
  else
    sudo apt update
    sudo apt install -y libclang-dev
  fi
  ;;
*)
  echo "Unknown Operating System"
  ;;
esac
