; main.asm

%define ENDL 0x0D, 0x0A

start:
    jmp main
puts:
    push si
    push ax

.loop:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0e
    int 0x10
    jmp .loop

.done:
    pop ax
    pop si
    ret

main:
    mov ax, 0
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    mov si, msg_hello
    call puts
    hlt

msg_hello: db 'This is my new OS', ENDL, 0
