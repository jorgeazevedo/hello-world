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
INSTALL_FILE = /usr/bin/install -m 644
DEL_FILE = rm -f
DESTINATION = /usr/bin
MANDESTINATION = /usr/share/man/man1

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
	$(DEL_FILE) $(OBJS)

clean: mostlyclean
	$(DEL_FILE) $(TARGET)

install: all
	$(INSTALL_PROGRAM) $(TARGET) $(DESTINATION)
	$(INSTALL_FILE) $(MANPAGE) $(MANDESTINATION)

uninstall:
	$(DEL_FILE) $(DESTINATION)/$(TARGET)
	$(DEL_FILE) $(MANDESTINATION)/$(MANPAGE)

dist: $(MANPAGE)
	mkdir -p $(TARNAME)
	ln main.c Makefile args.c args.h $(MANPAGE) $(TARNAME)/
	ln README.md $(TARNAME)/README
	tar chof - $(TARNAME) | GZIP='--no-name --best --rsyncable' gzip -c >$(TARNAME).tar.gz
	rm -rf $(TARNAME)

# $@ represents the left side of the ":"
# $^ represents the right side of the ":"
# $< represents the first item in the dependency list   
