TARGET = hello-world
OBJS = main.o args.o

INCLUDES = -I./
CC = gcc
G_OPTS := -W -lpthread
# Only generate object code files
C_OPTS := -c

VERSION = 1.0
TARNAME = $(TARGET)-$(VERSION)
MANPAGE = $(TARGET).1
INSTALL_PROGRAM = /usr/bin/install
DESTINATION = /usr/local/bin

.PHONY: clean cleanall install uninstall dist

all: $(TARGET) 

$(TARGET): $(OBJS)
	$(CC) $(G_OPTS) $(INCLUDES) $^ -o $@

%.o: %.c
	$(CC) $(G_OPTS) $(C_OPTS) $< $(INCLUDES) -o $@

man: $(MANPAGE)

$(MANPAGE): args.c
	help2man --no-info --output=$@ ./$(TARGET)

mostlyclean:
	rm -f $(OBJS)

clean: mostlyclean
	rm -f $(TARGET)

install: all
	$(INSTALL_PROGRAM) $(TARGET) $(DESTINATION)

uninstall:
	rm -f $(DESTINATION)/$(TARGET)

dist: $(MANPAGE)
	mkdir -p $(TARNAME)
	ln main.c Makefile args.c args.h $(MANPAGE) $(TARNAME)/
	tar chof - $(TARNAME) | GZIP='--no-name --best --rsyncable' gzip -c >$(TARNAME).tar.gz
	rm -rf $(TARNAME)

# $@ represents the left side of the ":"
# $^ represents the right side of the ":"
# $< represents the first item in the dependency list   
