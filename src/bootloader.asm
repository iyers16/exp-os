; bootloader.asm

org 0x7C00
bits 16

jmp main

%include "src/main.asm"

times 510-($-$$) db 0
dw 0AA55h
