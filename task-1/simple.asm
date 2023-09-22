%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here

next_position_in_string:

    xor eax, eax

    ;; memoreaza in al, valoarea elementului curent din stringul plain
    mov al, byte[esi + ecx - 1]

    ;; adaugam la valoarea elementului steps
    add eax, edx

    ;; comparam valoarea obtinuta cu 91, fiind primul cod ASCII aflat dupa 
    ;; literele mari ale alfabetului englez
    cmp eax, 91

    ;; daca codul ASCII nu reprezinta o litere, il transformam
    jge transform

    ;; calculam noua adresa
    mov byte[edi + ecx - 1], al
    
back:
    ;; trecem la urmatoarea pozitie din plain
    loop next_position_in_string
    jmp exit


transform:
    xor ebx, ebx
    mov ebx, eax

    ;; calculam cate pozitii trebuie sa adaugam de la litera 'A'
    sub ebx, 91

    ;; adaugam codul ASCII al lui 'A'
    add ebx, 65
    mov byte[edi + ecx - 1], bl

    ;; am obtinut elementul dorit
    jmp back

exit:

    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
