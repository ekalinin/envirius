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
	@rm -rf $(DST_HOME_CMD)
	@rm -rf $(DST_HOME_PLG)
	@install -d -m 0755 $(DST_HOME_CMD)
	@install -d -m 0755 $(DST_HOME_PLG)
	@install -m 0644 $(MAIN_FILES) $(DST_HOME)
	@install -m 0644 $(CMD_FILES) $(DST_HOME_CMD)
	@install -m 0644 $(PLG_FILES) $(DST_HOME_PLG)
	@echo "Please, add into your ~/.bashrc:"
	@echo ""
	@echo "# activate envirius"
	@echo '[ -f "$(DST_HOME)/nv" ] && . $(DST_HOME)/nv'

# save rc file & cache & created environments
uninstall:
	@rm -rf $(DST_HOME)/nv
	@rm -rf $(DST_HOME)/nv_common
	@rm -rf $(DST_HOME_CMD)
	@rm -rf $(DST_HOME_PLG)

tests:
	@time bats tests

release: tests
	@git tag `grep -o -E '[0-9]\.[0-9]\.[0-9]{1,2}' src/nv-commands/version`
	@git push --tags origin master

contributors:
	@git log --raw | grep "^Author: " | \
		sort | uniq -c | sort -n -r | \
		cut -d ':' -f 2 | sed 's/^/- /' | \
		cut -d '<' -f1 | uniq > CONTRIBUTORS.md

loc1:
	@find ./src/ -type f | xargs wc -l

loc2:
	@sloccount ./src

loc3:
	@cloc ./src/

lint:
	@shellcheck ./src/nv_common
