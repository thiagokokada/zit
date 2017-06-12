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
`ZIT_MODULES_PATH/.zim` (by default, `ZIT_MODULES_PATH` is defined as the value
of your `ZDOTDIR` variable or your home directory). However, if
`ZIT_MODULES_PATH/.zim` already exists, it will do nothing.

Zit also supports Git branches. To do so, pass the branch using `#branch` after
the repository url during `zit-install` call:

    $ zit-install https://github.com/zsh-users/zsh-autosuggestions#develop

**Important note:** Zit does not support changing branches after install. If
you want to change a branch of an already installed branch, go to the directory
of the installed plugin and call `git checkout branch-name` manually!

After install, you can load ZIM by running:

    $ zit-load ".zim" "init.zsh"

With this command, Zit will source the file named `init.zsh` inside
`ZIT_MODULES_PATH/.zim`. The second paramter supports glob patterns:

    $ zit-load ".zim" "*.zsh"

In this case, it would try to load all files with extension `.zsh` inside
`ZIT_MODULES_PATH/.zim` directory. Actually, the above is the default, so you
could also pass simply:

    $ zit-load ".zim"

You can also call both `zit-install` and `zit-load` in one step:

    $ zit-install-load "https://github.com/Eriner/zim/" ".zim" "init.zsh"
    # Or
    $ zit-install-load "https://github.com/Eriner/zim/" ".zim"

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

There is different ways to install Zit. The simplest one is to copy the file
`zit.zsh` somewhere in your home directory and source it in your `~/.zshrc`.
This will always work because I want the source code of Zit to be
self-contained inside this one file.

If you want to be fancy, you can also clone this repository:

    $ git clone https://github.com/m45t3r/zit.git "${HOME}/.zit"

And source the cloned diretory in your `~/.zshrc`

    source $HOME/.zit/zit.zsh

In the above case you could even put in your `~/.zshrc` (after above line):

    zit-load ".zit"

So Zit can manage Zit updates too.

## Supported versions

Zit supports ZSH version `5.1` and above. There are automated tests running in
the following versions of ZSH in [Travis-CI](travis-ci.org/m45t3r/zit):

- `5.1.1`
- `5.2`
- `5.3.1`

The tests are known to break in versions `<5.1`, however fixes are welcome if
you happen to use an older version of ZSH.

## FAQ

### Why zit install everything in home directory by default?

Because some plugins assume that they're running from home. If this isn't a
problem for you, you can simply set your `ZIT_MODULES_PATH` to something in
your `~/.zshrc`:

    ZIT_MODULES_PATH="$HOME/.zit.d"

### How can I compile my ZSH plugins to speed up initialization?

You can simply call compilation of your installed modules yourself inside your
`~/.zlogin`. Look at the `zlogin` file from Zim for example:
<https://github.com/Eriner/zim/blob/master/templates/zlogin>. You can simply
edit this file to include your `ZIT_MODULES_PATH`, for example.
