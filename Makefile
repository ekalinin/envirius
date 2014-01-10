prefix=/usr/local

# files that need mode 755
EXEC_FILES=uve

# files that need mode 644
CMD_FILES=uve-commands/*
PLG_FILES=uve-plugins/*

all:
	@echo "usage: make install"
	@echo "       make uninstall"

install:
	@install -d -m 0755 $(prefix)/bin
	@# delete prev installation
	@rm -rf $(prefix)/bin/uve-commands
	@rm -rf $(prefix)/bin/uve-plugins
	@install -d -m 0755 $(prefix)/bin/uve-commands
	@install -d -m 0755 $(prefix)/bin/uve-plugins
	@install -m 0755 $(EXEC_FILES) $(prefix)/bin
	@install -m 0644 $(CMD_FILES) $(prefix)/bin/uve-commands
	@install -m 0644 $(PLG_FILES) $(prefix)/bin/uve-plugins

install-local:
	@make install prefix=~
	@echo "Please, add into your ~/.bashrc:"
	@echo ""
	@echo "# set PATH so it includes user's private bin if it exists"
	@echo 'if [ -d "$$HOME/bin" ] ; then'
	@echo '    PATH="$$HOME/bin:$$PATH"'
	@echo "fi"
