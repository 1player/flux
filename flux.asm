    global _start

    %macro NEXT 0
    lodsq
    jmp rax
    %endmacro

    section .text

name_hello:
    push rsi
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msglen
    syscall
    pop rsi
    NEXT

name_exit:
    mov rax, 60
    mov rdi, 0
    syscall
    NEXT

_start:
    mov rsi, program
    NEXT

    section rodata
program:
    dq name_hello
    dq name_exit

msg: db "Hello, world!", 10
msglen: equ $ - msg
