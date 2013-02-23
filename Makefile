TARGET = hello-world
OBJS = main.o args.o

INCLUDES = -I./

COMPILER = gcc
G_OPTS := -W -lpthread
# Only generate object code files
C_OPTS := -c

VERSION = 1.0
TARNAME = $(TARGET)-$(VERSION)

TARGET_MAN = $(TARGET).1

.PHONY: clean cleanall install uninstall dist

all: $(TARGET) 

$(TARGET): $(OBJS)
	$(COMPILER) $(G_OPTS) $(INCLUDES) $^ -o $@

%.o: %.c
	$(COMPILER) $(G_OPTS) $(C_OPTS) $< $(INCLUDES) -o $@

man: $(TARGET_MAN)

$(TARGET_MAN): args.c
	help2man --no-info --output=$@ ./$(TARGET)

mostlyclean:
	rm -f $(OBJS)

clean: mostlyclean
	rm -f $(TARGET)

install: all
	/usr/bin/install $(TARGET) '/usr/local/bin'

uninstall:
	cd '/usr/local/bin' && rm -f $(TARGET)

dist: $(TARGET_MAN)
	mkdir -p $(TARNAME)
	ln main.c Makefile args.c args.h $(TARGET_MAN) $(TARNAME)/
	tar chof - $(TARNAME) | GZIP='--no-name --best --rsyncable' gzip -c >$(TARNAME).tar.gz
	rm -rf $(TARNAME)

# $@ represents the left side of the ":"
# $^ represents the right side of the ":"
# $< represents the first item in the dependency list   
