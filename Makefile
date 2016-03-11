CC := gcc
CFLAGS := -O2 -Wall -g -ansi -pedantic $(OPTFLAGS)
CFLAGS+= -MMD

SRCDIR := src
BUILDDIR := build
TARGET := ${BUILDDIR}/ogl_test

SOURCES := $(shell find $(SRCDIR) -type f -name *.c)
OBJECTS := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.c=.o))
LIB := -Llib -lSDL2
INC := -Iinclude


$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) $< $(INC) $(LIB) -o $@

$(BUILDDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(BUILDDIR)
	$(CC) $(CFLAGS) $(INC) -c -o $@ $<

clean:
	rm -r $(BUILDDIR) $(TARGET)

.PHONY: clean

-include $(OBJECTS:%.o=%.d)
