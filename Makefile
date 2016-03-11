CC := gcc
CFLAGS := -O2 -Wall -g -ansi -pedantic $(OPTFLAGS)
CFLAGS+= -MMD -DGLEW_STATIC

SRCDIR := src
BUILDDIR := build
TARGET := ${BUILDDIR}/ogl_test

SOURCES := $(shell find $(SRCDIR) -type f -name *.c)
OBJECTS := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.c=.o))
LIB := -Llib -lSDL2 -lGLEW -lGLU -lGL
INC := -Iinclude -I/usr/include/GL


$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) $(INC) $(LIB) -o $@

$(BUILDDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(BUILDDIR)
	$(CC) $(CFLAGS) $(INC) -c -o $@ $<

clean:
	rm -rf $(BUILDDIR) $(TARGET)

.PHONY: clean

-include $(OBJECTS:%.o=%.d)
