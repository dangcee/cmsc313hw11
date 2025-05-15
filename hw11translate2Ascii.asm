	section .data
	inputBuf db 0x83, 0x6A, 0x88, 0xDE, 0x9A, 0xC3, 0x54, 0x9A ; input
	newline db 0x0A					   ; Newline character (ASCII 0x0A)

	section .bss
	outputBuf resb 80  	; Reserve space for output (without initialization)

	section .text
	global _start

_start:
	xor ecx, ecx	; cleans index for inputBuf
	xor edi, edi	; cleans index for outputBuf

convert_loop:
	mov al, [inputBuf + ecx] ; Loads inputBuf byte into al
	cmp ecx, 8		 ; check for 8 bytes
	je print_output	 ; if yes jumps to output

	;;  Convert high nibble to ASCII
	shr al, 4
	cmp al, 0x0A
	jl low_nibble_conversion
	add al, 'A' - 10
	jmp store_high_nibble

low_nibble_conversion:
	add al, '0'		; Convert to '0'-'9' for values < 0xA

store_high_nibble:
	mov [outputBuf + edi], al ; store the high nibble ASCII in outputBuf
	inc edi		  ; Increment outputBuf index

	;;  converts low nibble to ASCII
	mov al, [inputBuf + ecx]
	and al, 0x0F
	cmp al, 0x0A
	jl low_nibble_conversion2
	add al, 'A' - 10
	jmp store_low_nibble

	;;  convert to 0-9 for values less than 0xA
low_nibble_conversion2:
	add al, '0'

store_low_nibble:
	mov [outputBuf + edi], al
	inc edi

	;;  adds space for every pair of hex digits
	mov byte [outputBuf + edi], ' '
	inc edi

	inc ecx		; Increment ECX to process the next byte
	jmp convert_loop	; Continue the loop

print_output:
	;;  prints outputBuf
	mov eax, 4
	mov ebx, 1
	lea ecx, [outputBuf]
	mov edx, edi
	int 0x80

	;;  prints newlines
	mov eax, 4
	mov ebx, 1
	lea ecx, [newline]
	mov edx, 1
	int 0x80

	mov eax, 4
	mov ebx, 1
	lea ecx, [newline]
	mov edx, 1
	int 0x80

	;;  exits
	mov eax, 1
	xor ebx, ebx
	int 0x80
	
