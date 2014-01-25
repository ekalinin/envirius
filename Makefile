prefix=/usr/local

MAIN_FILES=mem
CMD_FILES=mem-commands/*
PLG_FILES=mem-plugins/*

all:
	@echo "usage: make install"
	@echo "       make uninstall"

install:
	@install -d -m 0755 $(prefix)/bin
	@# delete prev installation
	@rm -rf $(prefix)/bin/mem-commands
	@rm -rf $(prefix)/bin/mem-plugins
	@install -d -m 0755 $(prefix)/bin/mem-commands
	@install -d -m 0755 $(prefix)/bin/mem-plugins
	@install -m 0644 $(MAIN_FILES) $(prefix)/bin
	@install -m 0644 $(CMD_FILES) $(prefix)/bin/mem-commands
	@install -m 0644 $(PLG_FILES) $(prefix)/bin/mem-plugins

install-local:
	@make install prefix=~
	@echo "Please, add into your ~/.bashrc:"
	@echo ""
	@echo "# activate mem"
	@echo 'if [ -e "$$HOME/bin/mem" ] ; then'
	@echo '    . $$HOME/bin/mem'
	@echo "fi"
	@echo ""
	@echo "# auto env activation"
	@echo 'if [ -e ".mem" ] ; then'
	@echo '    mem on `cat .mem`'
	@echo "fi"
