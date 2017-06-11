#!/bin/sh

if [ ! -d "${HOME}/zsh/bin" ]; then
  pushd "${HOME}"
  curl -L http://downloads.sourceforge.net/zsh/${USING_ZSH_VERSION}.tar.gz | tar zx
  pushd "${USING_ZSH_VERSION}"
  ./configure --prefix="${HOME}/zsh"
  make -j2
  make install
  popd; popd
else
  echo "Using cached directory."
fi
