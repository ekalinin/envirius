.PHONY: install all tests uninstall

MAIN_FILES =./src/mem
MAIN_FILES+=./src/mem_common
CMD_FILES=./src/mem-commands/*
PLG_FILES=./src/mem-plugins/*

prefix=~
DST_HOME=$(prefix)/.mem
DST_HOME_CMD=$(DST_HOME)/mem-commands
DST_HOME_PLG=$(DST_HOME)/mem-plugins

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
	@echo 'if [ -e "$(DST_HOME)/mem" ] ; then'
	@echo '    . $(DST_HOME)/mem'
	@echo "fi"
	@echo ""
	@echo "# auto env activation"
	@echo 'if [ -e ".mem" ] ; then'
	@echo '    mem on `cat .mem`'
	@echo "fi"

# save rc file & cache & created environments
uninstall:
	@rm -rf $(DST_HOME)/mem
	@rm -rf $(DST_HOME_CMD)
	@rm -rf $(DST_HOME_PLG)

tests:
	bats tests
