PWD=`pwd`
export CGL_CONFIG_FILE="$PWD/conf/single.conf"
apitrace="$PWD/../apitrace/build/apitrace"
trace="$PWD/tests/anholt.trace"
GDB="gdb -ex run -quiet --args"
cgl_render="$PWD/runtime/cgl-render"
cgl_capture="$PWD/runtime/cgl-capture"

( sleep 1 && $cgl_capture $apitrace replay $trace ) &
$GDB $cgl_render center
