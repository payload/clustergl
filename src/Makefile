#################################
# ClusterGL main makefile
#################################

NAME    = cgl
render  = ../runtime/$(NAME)-render
capture = ../runtime/lib$(NAME)-capture.so

SOURCES := $(wildcard *.cpp)
OBJS    := $(patsubst %.cpp, %.o, $(SOURCES))

#OK. So, we don't want to link mod_app with the standalone app. So we link in
#a dummy one instead. This works, as at runtime we don't use it, it just makes
#the linker happy. In order to do this, we build up two objects lines
OBJS_SHARED := $(patsubst mod_app_dummy.o,,$(OBJS))
OBJS_APP    := $(patsubst mod_app.o,,$(OBJS))

CC            = g++
CXXFLAGS      = -std=c++11 $(ARCH) -I/opt/local/include/ -Iinclude -O2 -Wextra -g -fPIC -fvisibility-inlines-hidden
LDFLAGS       = $(CXXFLAGS)
LDLIBS        = -lconfuse -llzo2 -lz `sdl-config --cflags --libs` -lSDL_net -lconfuse -lGLEW -lpthread
DARWIN_LDLIBS = -framework,Cocoa -framework OpenGL -lintl
LINUX_LDLIBS  = -lGL -lGLU

# architectecture specific
UNAME  := $(shell uname -s)
ifeq ($(UNAME),Darwin)
LDLIBS += $(DARWIN_LDLIBS)
endif
ifeq ($(UNAME),Linux)
LDLIBS += $(LINUX_LDLIBS)
endif

all: $(SOURCES:.cpp=.d) $(render) $(capture)

# dependencies
%.d: %.cpp
	$(CC) -MM -MF $@ -MT "$(@:.d=.o) $@" $(CXXFLAGS) $<
-include $(SOURCES:.cpp=.d)

# compile targets
$(render): $(OBJS_APP)

$(capture): LDFLAGS += --shared
$(capture): $(OBJS_SHARED)

# other targets
clean:
	rm -f *.o *.d $(capture) $(render)

