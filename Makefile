PROJECT = hello-world
OBJS = main.o args.o

INCLUDES = -I./

COMPILER = gcc
G_OPTS := -W -lpthread
# Only generate object code files
C_OPTS := -c

BUILD_VERSION = $(shell git describe | cut -c 2-)
TARNAME = $(PROJECT)-$(BUILD_VERSION)

PROJECT_MAN = $(PROJECT).1

.PHONY: clean cleanall install uninstall dist

all: $(PROJECT) $(PROJECT_MAN)

$(PROJECT_MAN) : $(PROJECT) args.c
	help2man --no-info --output=$@ ./$(PROJECT)

$(PROJECT): $(OBJS)
	$(COMPILER) $(G_OPTS) $(INCLUDES) $^ -o $@

%.o: %.c
	$(COMPILER) $(G_OPTS) $(C_OPTS) $< $(INCLUDES) -o $@

mostlyclean:
	rm -f $(OBJS)

clean: mostlyclean
	rm -f $(PROJECT) $(PROJECT_MAN)

install: all
	/usr/bin/install -c $(PROJECT)  '/usr/local/bin'

uninstall:
	cd '/usr/local/bin' && rm -f $(PROJECT)

dist:
	mkdir -p $(TARNAME)
	ln main.c Makefile $(TARNAME)/
	tar chof - $(TARNAME) | GZIP='--no-name --best --rsyncable' gzip -c >$(TARNAME).tar.gz
	rm -rf $(TARNAME)

# $@ represents the left side of the ":"
# $^ represents the right side of the ":"
# $< represents the first item in the dependency list   
