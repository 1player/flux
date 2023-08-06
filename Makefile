flux: flux.asm
	nasm -f elf64 -o flux.o flux.asm
	ld -o flux flux.o

clean:
	rm -f flux.o flux
.PHONY: clean
