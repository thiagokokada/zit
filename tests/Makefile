.PHONY:

all: info shellcheck tests

info:
	@uname -a
	@git --version
	@zsh --version

shellcheck:
	@shellcheck --version
	@shellcheck -s bash "../zit.zsh"

tests:
	@zsh "./test_zit_aliases.zsh"
	@zsh "./test_zit_install.zsh"
	@zsh "./test_zit_install_load.zsh"
	@zsh "./test_zit_load.zsh"
	@zsh "./test_zit_update.zsh"
	@zsh "./test_zit_integration.zsh"
