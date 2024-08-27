all: animation xsine hello

animation: circle.c showdot.s
	gcc circle.c showdot.s -Wall -Wextra -lX11 -lXext -lm -o animation
xsine: xsine.asm 
	nasm -f elf64 -g -F dwarf xsine.asm    # -g -F dwarf adds debugging stuff
	gcc -no-pie -o xsine xsine.o -lc

clean:
	rm -f animation
	rm -f *.o
	rm -f xsine

