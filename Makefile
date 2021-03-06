all:
	@export ARCH
	$(MAKE) -C src
	$(MAKE) -C runtime/tests

compile-src:
	$(MAKE) -C src

clean:
	$(MAKE) clean -C src
	$(MAKE) clean -C runtime/tests
		
test:
	export CGL_CONFIG_FILE=./my.conf && \
	cd runtime && \
	gnome-terminal -e "./cgl-render left" && \
	gnome-terminal -e "./cgl-render center" && \
	gnome-terminal -e "./cgl-render right" && \
	sleep 1 && \
	gnome-terminal -e "./cgl-capture tests/row/row"

debug-anholt: compile-src
	./tests/anholt.sh

debugrender:
	cd runtime && \
	gdb -ex run -quiet --args ./cgl-render center


install:
	@cp runtime/cgl-render /usr/bin/ -v
	@cp runtime/cgl-capture /usr/bin/ -v
	@cp runtime/libcgl-capture.so /usr/lib -v
	@cp runtime/cgl.conf /etc/ -v

uninstall:
	@rm -fv /usr/bin/cgl-render /usr/bin/cgl-capture /usr/lib/libcgl-capture.so /etc/cgl.conf
