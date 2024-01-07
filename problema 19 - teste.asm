; 19. Sa se citeasca de la tastatura un numar n, apoi sa se citeasca mai multe cuvinte, pana cand se citeste cuvantul/caracterul "#". Sa se scrie intr-un fisier text toate cuvintele citite care incep si se termina cu aceeasi litera si au cel putin n litere.
bits 32
global start

extern exit, fopen, fclose, fprintf, scanf, printf          
import exit msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll    
import fprintf msvcrt.dll    
import scanf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    n dd 0
    nume_fisier db "cuvinte.txt", 0
    mod_acces db "w", 0
    descriptor_fis dd -1
    format_numar db "%d", 0
    msg db "n = ", 0
    format_cuvant db "%s", 0
    msg_cuv db "cuvant = ", 0
    buffer resb 100
    format_spatiu db "%s ", 0
    
segment code use32 class=code
start:
    push dword mod_acces     
    push dword nume_fisier
    call [fopen]
    add ESP, 4 * 2
    
    mov [descriptor_fis], EAX
    
    cmp EAX, 0
    je fail
    
    push dword msg
    call [printf]
    add ESP, 4 * 1
    
    push dword n
    push dword format_numar
    call [scanf]
    add ESP, 4 * 2
    
    
citeste_cuvant:
    push dword msg_cuv
    call [printf]
    add ESP, 4 * 1
    
    push dword buffer
    push dword format_cuvant
    call [scanf]
    add ESP, 4 * 2
    
    cmp byte [buffer], '#'
    je final
    
    mov ESI, 0
    
loop_check_end:
    cmp byte[buffer + ESI], 0
    je word_end
    inc ESI
    jmp loop_check_end
    
word_end:
    cmp ESI, [n]
    jl citeste_cuvant

    mov CL, byte[buffer + ESI - 1]
    cmp [buffer], CL
    je scrie_cuvant
    jmp citeste_cuvant

    
scrie_cuvant:
    push dword buffer
    push dword format_cuvant
    push dword [descriptor_fis]
    call [fprintf]
    add ESP, 4 * 3
    
    jmp citeste_cuvant
    
final:
    push dword [descriptor_fis]
    call [fclose]
    add ESP, 4 * 1
    
fail:

    push dword 0
    call [exit]
    