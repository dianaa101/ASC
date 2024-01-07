; Se citeste de la tastatura un sir de caractere (litere mici si litere mari, cifre, caractere speciale, etc). Sa se formeze un sir nou doar cu literele mici si un sir nou doar cu literele mari. Sa se afiseze cele 2 siruri rezultate pe ecran.
; S: 'a', 'A', 'b', 'B', '2', '%', 'x'
; D1: 'a', 'b', 'x'
; D2: 'A', 'B'

bits 32
global start

extern exit, printf, scanf
import exit msvcrt.dll  
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    size equ 32
    s times size db 0
    msg1 db "uppercase: "
    d1 times size db 0
    msg2 db "lowercase: "
    d2 times size db 0
    
segment code use32 class=code
start:
    mov ECX, [size]
    jecxz final 
    
    mov ESI, 0
    mov EDI, 0 ; for d1
    mov EBX, 0 ; for d2
    
repeta:
    mov AL, [s+ESI]
    
    cmp AL, 'A'
    jl not_uppercase ;Jump if below A
    
    cmp AL, 'Z'
    jg not_uppercase ;Jump if greater than Z
    
    mov [d1+EDI], AL
    inc EDI
    jmp next_char
    
not_uppercase:
    cmp AL, 'a'
    jl not_letter
    
    cmp AL, 'z'
    jg not_letter
    
    mov [d2+EBX], AL
    inc EBX
    jmp next_char
    
not_letter:
    jmp next_char
    
next_char:   
    inc ESI
    loop repeta

final:

    push dword 0 
    call [exit]