# Makefile for idris2-agent-tools

.PHONY: all dylib test test-ast test-ctags install-ctags clean

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
    CC := clang
    DYLIB_FLAGS := -arch x86_64 -arch arm64
else
    CC ?= gcc
    DYLIB_FLAGS :=
endif

all: dylib

dylib:
	cd vendor/tree-sitter-idris2 && $(CC) -O3 -shared -fPIC $(DYLIB_FLAGS) -Isrc src/parser.c src/scanner.c -o tree-sitter-idris2.dylib

test: test-ast test-ctags

test-ast: dylib
	ast-grep test -c sgconfig.yml

test-ctags:
	./test/test_ctags.sh

install-ctags:
	mkdir -p $(HOME)/.ctags.d
	cp ctags.d/idris2.ctags $(HOME)/.ctags.d/idris2.ctags
	@echo "Installed idris2.ctags to $(HOME)/.ctags.d/idris2.ctags"

clean:
	rm -f vendor/tree-sitter-idris2/tree-sitter-idris2.dylib tags
