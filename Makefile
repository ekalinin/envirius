.PHONY: install all tests uninstall release

MAIN_FILES =./src/nv
MAIN_FILES+=./src/nv_common
CMD_FILES=./src/nv-commands/*
PLG_FILES=./src/nv-plugins/*

prefix=~
DST_HOME=$(prefix)/.envirius
DST_HOME_CMD=$(DST_HOME)/nv-commands
DST_HOME_PLG=$(DST_HOME)/nv-plugins

all:
	@echo "usage: make install"
	@echo "       make uninstall"

install:
	@install -d -m 0755 $(DST_HOME)
	@# delete prev installation
	@rm -rf $(DST_HOME_PLG)
	@rm -rf $(DST_HOME_PLG)
	@install -d -m 0755 $(DST_HOME_CMD)
	@install -d -m 0755 $(DST_HOME_PLG)
	@install -m 0644 $(MAIN_FILES) $(DST_HOME)
	@install -m 0644 $(CMD_FILES) $(DST_HOME_CMD)
	@install -m 0644 $(PLG_FILES) $(DST_HOME_PLG)
	@echo "Please, add into your ~/.bashrc:"
	@echo ""
	@echo "# activate mem"
	@echo 'if [ -e "$(DST_HOME)/nv" ] ; then'
	@echo '    . $(DST_HOME)/nv'
	@echo "fi"
	@echo ""
	@echo "# auto env activation"
	@echo 'if [ -e ".envirius" ] ; then'
	@echo '    mem on `cat .envirius`'
	@echo "fi"

# save rc file & cache & created environments
uninstall:
	@rm -rf $(DST_HOME)/env
	@rm -rf $(DST_HOME_CMD)
	@rm -rf $(DST_HOME_PLG)

tests:
	bats tests

release:
	@git tag `grep -o -E '[0-9]\.[0-9]\.[0-9]{1,2}' src/nv-commands/version`
	@git push --tags origin master
