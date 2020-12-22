output:
	mkdir -p build
	rgbasm main -o build/main.o src/main.asm
	rgblink -o build/main.gb build/main.o
	rgbfix -v -p 0 build/main.gb

clean:
	rm -rf build
