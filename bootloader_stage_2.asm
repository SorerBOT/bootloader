[BITS 16]
[ORG 0x7E00]

%define CLRF 0x0D, 0x0A
%define OS_STATUS "[sOS]"
%define GDT_BASE_ADDRESS

start:
    xor ax, ax
    mov ds, ax
    mov si, msg_stage_2
print_msg:
    mov al, [si]
    test al, al
    jz print_msg_finished
    mov ah, 0x0E            ; BIOS interrupt for printing a character
    int 0x10
    inc si
    jmp print_msg


print_msg_finished:
    jmp $                   ; Hang forever

GDT:
    dq 0x00000000               ; the first entry must be null

ENTRY_SEGMENT_DATA:
    dw 0xFFFF                   ; lower part limit
    dw 0x0000                   ; lower part base
    db 0x00                     ; middle part base
    db 0b10010010               ; access byte
    db 0b11000000 | 0b00001111  ; 0b00001111 = the upper part limit, 0b11000000 = flags
    db 0x00                     ; upper part base

ENTRY_SEGMENT_CODE:
    dw 0xFFFF                   ; lower part limit
    dw 0x0000                   ; lower part base
    db 0x00                     ; middle part base
    db 0b10011010               ; access byte
    db 0b11000000 | 0b00001111  ; 0b00001111 = the upper part limit, 0b11000000 = flags
    db 0x00                     ; upper part base










    

msg_stage_2 db OS_STATUS, ": booting...", CLRF, OS_STATUS, ": stage 1 completed...", CLRF, OS_STATUS, ": running stage 2...", 0
