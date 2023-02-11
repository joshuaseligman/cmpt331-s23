build:
	rm -f caesar.o
	rm -f caesar
	riscv64-unknown-elf-as -g -c caesar.s -o caesar.o
	riscv64-unknown-elf-gcc -g caesar.o -o caesar -nostdlib -static

run:
	riscv64-unknown-elf-run caesar

debug:
	riscv64-unknown-elf-gdb caesar

dump:
	riscv64-unknown-elf-objdump -d -M no-aliases caesar.o