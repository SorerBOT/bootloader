; Booting Sequence:
;   - Firmware runs and ensures all electrical devices are OK.
;   - Firmware runs BIOS which are just some code directly embedded
;           on the motherboard and meant to be the entry point of the PC.
;   - BIOS search the first 512 bytes of every drive, and check if they
;           terminate with the magic number: 0x55AA (big endian).
;   - BIOS copy these 512 bytes to address 0x7c00 and JMP to it
;   - This is where our bootloader comes to life.
[BITS 16]               ; setting 16-bit mode
[ORG 0x7C00]

start:
    jmp load_stage_2


load_stage_2:
                        ; BIOS store the current boot driveID in dl. We need not set it ourselves.
    mov si, DAP
    mov ah, 0x42
    int 0x13
    jc error            ; CF==1 means that an error has occurred.
    jmp 0x1000          ; jump to the RAM address where we loaded the code

error:
    jmp $               ; infinite loop. I use it to keep QEMU open



; Defining DAP for BIOS Interrupt 13h which reads from disk and writes to RAM
align 4                 ; Just to be safe, align on 4-byte boundary
DAP:
    db 0x10             ; Packet Size, this tells the BIOS what version of DAP struct we're using
    db 0x00             ; Padding byte. Needs to be reset to 0 if ran in a loop
    dw 0x4000           ; [2] Count: Number of sectors to read (1 sector)

                        ; RAM address to write to is represented by (Segment * 16) + Offset
    dw 0x1000           ; Offset
    dw 0x0000           ; Segment

    dq 0x00000001       ; Disk sector to read from, each sector is 512 bytes.
                        ; the first one contains this file, the next sector will contain stage 2.





; Adding the magic number at the end of the 512 bytes indicates that this is a bootloader
times 510-($-$$) db 0
dw 0xAA55
