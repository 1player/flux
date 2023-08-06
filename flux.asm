    global _start

    %macro NEXT 0
    lodsq                       ; load next instruction in rax
    jmp [rax]                   ; jump to its codeword
    %endmacro

    %macro PUSHRSP 1
    lea rbp, [rbp - 8]
    mov [rbp], %1
    %endmacro

    %macro POPRSP 1
    mov [rbp], %1
    lea rbp, [rbp + 8]
    %endmacro

    SECTION .text

name_hello:
    dq .next
.next
    push rsi
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msglen
    syscall
    pop rsi
    NEXT

name_exit:
    dq .next
.next
    mov rax, 60
    mov rdi, 0
    syscall
    NEXT

DOCOL:
    PUSHRSP rsi                 ; push rsi on the return stack
    add rax, 8                  ; move past the codeword
    mov rsi, rax                ; point rsi to the first data word
    NEXT

_start:
    cld
    mov rbp, top_of_return_stack
    mov rsi, program
    NEXT


    SECTION .bss

bottom_of_return_stack:
    resb 4096
top_of_return_stack:


    SECTION .rodata

msg: db "Hello, world!", 10
msglen: equ $ - msg

    align 8
program:
    dq name_hello
    dq name_exit
