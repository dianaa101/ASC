; 12. Se citesc 3 numere din fisier. Sa se afiseze inmultirea lor pe ecran.
bits 32
global start

extern exit, printf, fopen, fclose, fscanf, scanf, fprintf
import exit msvcrt.dll
import printf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fscanf msvcrt.dll
import scanf msvcrt.dll
import fprintf msvcrt.dll

segment data use32 class=data
    a dd 0
    b dd 0
    c dd 0
    nume_fisier db "numere.txt", 0
    mod_acces db "w", 0
    descriptor_fisier dd 0
    format_numar db "%d", 0
    mesaj db "Inmultirea: %d", 0
    
segment code use32 class=code
start:
    push dword mod_acces
    push dword nume_fisier
    call [fopen]
    add ESP, 4 * 2
    
    mov [descriptor_fisier], EAX
    
    push dword mesaj
    call [printf]
    add ESP, 4 * 1
    
    cmp EAX, 0
    je fail
       
    xor EBX, EBX
    
citire_numere: 
    push dword a
    push dword format_numar
    push dword [descriptor_fisier]
    call [scanf]
    add ESP, 4 * 3
    
    push dword b
    push dword format_numar
    push dword [descriptor_fisier]
    call [scanf]
    add ESP, 4 * 3
    
    push dword c
    push dword format_numar
    push dword [descriptor_fisier]
    call [scanf]
    add ESP, 4 * 3
    

    mov EAX, [a]
    mov EBX, [b]
    imul EBX, EAX
    mov ECX, [c]
    imul EBX, ECX
    
scriere_numere:
    push dword EBX    
    push dword [descriptor_fisier]
    call [fprintf]
    add ESP, 4 * 2
    

final:
    push dword [descriptor_fisier]
    call [fclose]
    add ESP, 4 * 1
    
fail:
    push dword 0
    call [exit]
