PROJECT = hello-world
OBJS = main.o

INCLUDES = -I./

COMPILER = gcc
G_OPTS := -W -lpthread
# Only generate object code files
C_OPTS := -c

BUILD_VERSION = $(shell git describe | cut -c 2-)
TARNAME = $(PROJECT)-$(BUILD_VERSION)

.PHONY: clean cleanall
all: $(PROJECT)

$(PROJECT): $(OBJS)
	$(COMPILER) $(G_OPTS) $(INCLUDES) $^ -o $@

%.o: %.c
	$(COMPILER) $(G_OPTS) $(C_OPTS) $< $(INCLUDES) -o $@

clean:
	rm -f $(OBJS)

cleanall: clean
	rm -f $(PROJECT)

dist:
	mkdir -p $(TARNAME)
	ln main.c Makefile $(TARNAME)/
	tar chof - $(TARNAME) | GZIP='--no-name --best --rsyncable' gzip -c >$(TARNAME).tar.gz
	rm -rf $(TARNAME)

# $@ represents the left side of the ":"
# $^ represents the right side of the ":"
# $< represents the first item in the dependency list   
