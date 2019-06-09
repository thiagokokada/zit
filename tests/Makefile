.SILENT:
.PHONY:

all: info shellcheck tests

info:
	echo "###############"
	echo "# System info #"
	echo "###############"
	uname -a
	git --version
	zsh --version
	echo

shellcheck:
	echo "########"
	echo "# Lint #"
	echo "########"
	shellcheck --version
	shellcheck -s bash "../zit.zsh"
	echo

tests:
	echo "#################"
	echo "# Running tests #"
	echo "#################"
	zsh "./test_zit_aliases.zsh"
	zsh "./test_zit_install.zsh"
	zsh "./test_zit_install_load.zsh"
	zsh "./test_zit_load.zsh"
	zsh "./test_zit_upgrade.zsh"
	zsh "./test_zit_remove.zsh"
	zsh "./test_zit_integration.zsh"
	echo
