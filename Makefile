all : bubble 

bubble : bubble.o
	ld bubble.o -o bubble -lc --dynamic-linker /lib64/ld-linux-x86-64.so.2

bubble.o : bubble.asm
	nasm -felf64 -o bubble.o bubble.asm

clean :
	rm -rf bubble.o bubble

