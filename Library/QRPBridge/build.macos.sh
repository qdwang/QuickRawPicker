clang++ -arch x86_64 -arch arm64 -dynamiclib -O3 -o ../../GUI/Asset/Lib/Bin/QRPBridge.dylib -lz -I./godot-headers -I../LibRaw -I../libjpeg-turbo main.cpp ../LibRaw/lib/libraw_mod.macos.a ../libjpeg-turbo/lib/libturbojpeg.macos.a
