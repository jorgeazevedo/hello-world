PROJECT = hello-world
OBJS = main.o args.o

INCLUDES = -I./

COMPILER = gcc
G_OPTS := -W -lpthread
# Only generate object code files
C_OPTS := -c

VERSION = 1.0
TARNAME = $(PROJECT)-$(VERSION)

PROJECT_MAN = $(PROJECT).1

.PHONY: clean cleanall install uninstall dist

all: $(PROJECT) 

$(PROJECT): $(OBJS)
	$(COMPILER) $(G_OPTS) $(INCLUDES) $^ -o $@

%.o: %.c
	$(COMPILER) $(G_OPTS) $(C_OPTS) $< $(INCLUDES) -o $@

man: $(PROJECT_MAN)

$(PROJECT_MAN): args.c
	help2man --no-info --output=$@ ./$(PROJECT)

mostlyclean:
	rm -f $(OBJS)

clean: mostlyclean
	rm -f $(PROJECT)

install: all
	/usr/bin/install $(PROJECT) '/usr/local/bin'

uninstall:
	cd '/usr/local/bin' && rm -f $(PROJECT)

dist: $(PROJECT_MAN)
	mkdir -p $(TARNAME)
	ln main.c Makefile args.c args.h $(PROJECT_MAN) $(TARNAME)/
	tar chof - $(TARNAME) | GZIP='--no-name --best --rsyncable' gzip -c >$(TARNAME).tar.gz
	rm -rf $(TARNAME)

# $@ represents the left side of the ":"
# $^ represents the right side of the ":"
# $< represents the first item in the dependency list   
