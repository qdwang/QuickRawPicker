g++ main.cpp ../LibRaw/lib/libraw_mod.linux.a ../libjpeg-turbo/lib/libturbojpeg.linux.a \
-o ../../GUI/Asset/Lib/Bin/QRPBridge.so \
-Wall -pedantic -Wextra -Wno-unused-parameter \
-fpic -shared \
-lz \
-Ofast -funroll-loops \
-I./godot-headers -I../LibRaw -I../libjpeg-turbo 
