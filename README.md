# cmsc313hw11
Charles Dang's submission for CMSC313 HW11

Program description:
    The program reads a sequence of bytes, processes each byte and converts to hexadecimal ASCII equivalent, and prints the result.

Compiling and Executing:
  1. Go into terminal
  2. Go into desired directory with file: "hw11translate2Ascii.asm" in it.
  3. Assemble using this command:
      nasm -f elf32 -o hw11translate2Ascii.o hw11translate2Ascii.asm
  4. Link using this command:
      ld -m elf_i386 -s -o hw11translate2Ascii hw11translate2Ascii.o
  5. Execute using this command:
      ./hw11translate2Ascii

  6. Output should be similar to the following:
      [c264@linux5 HW11]$ ./hw11translate2Ascii
      83 6A 88 DE 9A C3 54 9A
     
      [c264@linux5 HW11]$
