# Zit

## minimal plugin manager for ZSH

[![Build Status](https://travis-ci.org/m45t3r/zit.svg?branch=master)](https://travis-ci.org/m45t3r/zit)

Zit is yet another plugin manager for ZSH. It is minimal because it implements
the bare minimum to be qualified as a plugin manager: it allows the user to
install plugins from Git repositories (and Git repositories only, them why
the name), source plugins and update them. It does not implement fancy
functions like cleanup of removed plugins, automatic compilation of installed
plugins, alias for oh-my-zsh/prezto/other ZSH frameworks, building binaries,
PATH manipulation and others.

It should be as simple as it can be, minimal enough that if you want you can
simply copy and paste the whole Zit source to your `~/.zshrc` and it would
work.

## Usage

The first command of Zit is `install`:

    $ zit-install "https://github.com/Eriner/zim/" ".zim"

The command above will clone [Eriner/zim](https://github.com/Eriner/zim) inside
`ZIT_MODULES_PATH/.zim` during the next start of your ZSH (or if you do a
`source ~/.zshrc`). However, if `ZIT_MODULES_PATH/.zim` already exists, it will
do nothing.

By the way, the default value of `ZIT_MODULES_PATH` is defined as the value of
your `ZDOTDIR` variable or your home directory.

After install, you can load ZIM by running:

    $ zit-load ".zim" "init.zsh"

Zit also supports Git branches. To do so, pass the branch using `#branch` after
the repository url during `zit-install` call:

    $ zit-install "https://github.com/zsh-users/zsh-autosuggestions#develop" ".zsh-autosuggestions"

**Important note:** Zit does not support changing branches after install. If
you want to change a branch of an already installed branch, go to the directory
of the installed plugin and call `git checkout branch-name` manually!

You can also call both `zit-install` and `zit-load` in one step:

    $ zit-install-load "https://github.com/Eriner/zim/" ".zim" "init.zsh"

Finally, Zit can also update all your installed plugins. For this one you
simply need to run:

    $ zit-update

And Zit will update all your plugins.

Of course, instead of typing this command at the start of your session
everytime, you can simply put in your `~/.zshrc`.

## Aliases

Zit also provide some command alias so you can type slightly less:

| Command            | Alias    |
| ------------------ | -------- |
| `zit-install`      | `zit-in` |
| `zit-load`         | `zit-lo` |
| `zit-install-load` | `zit-il` |
| `zit-update`       | `zit-up` |

## Installation

There are different ways to install Zit. The simplest one is to copy the file
`zit.zsh` somewhere in your home directory and source it in your `~/.zshrc`.
This will always work because I want the source code of Zit to be
self-contained inside this one file.

If you want to be fancy, you can also clone this repository:

    $ git clone https://github.com/m45t3r/zit.git "${HOME}/.zit"

And source the cloned diretory in your `~/.zshrc`

    source $HOME/.zit/zit.zsh

In the above case you could even put in your `~/.zshrc` (after above line):

    zit-load ".zit" "zit.zsh"

So Zit can manage Zit updates too.

## Supported versions

Zit supports ZSH version `5.0.0` and above. There are automated tests running
in the following versions of ZSH in [Travis-CI](https://travis-ci.org/m45t3r/zit):

- `5.0.8`
- `5.1.1`
- `5.2`
- `5.3.1`

For Git, version `1.9.0` and above are supported.

## Examples

You can see examples of Zit utilization in
[my dotfiles](https://github.com/m45t3r/dotfiles/tree/master/zsh).

## FAQ

### Why zit install everything in home directory by default?

Because some plugins assume that they're running from home. If this isn't a
problem for you, you can simply set your `ZIT_MODULES_PATH` to something in
your `~/.zshrc`:

    export ZIT_MODULES_PATH="$HOME/.zit.d"

If you set `ZIT_MODULES_PATH`, and there is one plugin that has hard-coded
paths, you can do the following:

    ZIT_MODULES_PATH="$HOME" zit-in "https://github.com/author/random" ".random"
    ZIT_MODULES_PATH="$HOME" zit-lo ".random" "random.zsh"

### How can I compile my ZSH plugins to speed up initialization?

The script `extras/compile-zsh-files.zsh` shows an example on how to compile
ZSH files and plugins. You can copy it somewhere and adapt it to your needs,
or you can call it directly by adding the following lines **at the end of your
`~/.zshrc`**:

    zit-in "https://github.com/m45t3r/zit" ".zit" # Skip if Zit is already installed
    zit-lo ".zit" "extras/compile-zsh-files.zsh"

### How can I run a bash/ksh/sh plugin?

You can simply try `zit-in/zit-lo` or `zit-il` and see if it will work. If
not, you can try to run `zit lo` in compatibility mode:

    # You can't use zit-il in this case, since we want to run only zit-lo in emulation mode.
    zit-in "https://github.com/author/random-bash-plugin" "random-bash-plugin"
    # You may need to avoid aliases in emulation mode
    emulate bash -c 'zit-load "random-bash-plugin" "plugin.bash"'

Just remember that this may not work either since ZSH emulation is not
perfect.

### How can I use Zit to manage scripts like fasd?

If you want to use Zit to manage scripts that should be added to the `PATH`
instead of using `source` to load, you can do the following:

    zit-in "https://github.com/clvv/fasd" "fasd"
    export PATH="${ZIT_MODULES_PATH}/fasd:${PATH}"

### How can I use Zit to manage local plugins?

Passing the last parameter as `0` to `zit-load` does the trick:

    zit-load ".local-plugin" "local.zsh" 0 # disables upgrade

This will load a local plugin from `~/.local-plugin` directory named `local.zsh`
and disables upgrade for this module, so `zit-update` does not try to update it.

### How can I force a specific version of module in Zit?

Both `zit-install-load` and `zit-install` also supports last parameter `0` to
disable upgrading:

    zit-install "https://github.com/Eriner/zim/" ".zim" 0 
    zit-install-load "https://github.com/Eriner/zim/" ".zim" "init.zsh" 0

So lets say you want to use `Eriner/zim` with commit `abcde`, you can declare
in your `~/.zshrc` the last command above and run:

    $ cd ~/.zim
    $ git checkout abcde
