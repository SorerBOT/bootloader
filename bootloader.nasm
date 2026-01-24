section .data
section .bss
section .text
        global _start
_start:



; Magic Number at the end of the 512 bytes indicates that this is a bootloader
times 510-($-$$) db 0
dw 0xAA55
