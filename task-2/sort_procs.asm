%include "../include/io.mac"

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

section .text
    global sort_procs

sort_procs:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov edx, [ebp + 8]      ; processes
    mov eax, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here
    imul eax, 5
    xor ecx, ecx

;; parcurgem elementele vectorului de structuri proc 
iterate:
    ;; memoram in ebx campul .prio al elementul curent i
    movzx ebx, byte[edx + ecx + 2]
    mov edi, ecx
    add edi, 5

;; incepand cu pozitia urmatoare din vectorul de structuri proc
;; comparam valoarea memorata in ebx cu valoarea campului .prio al
;; elementelor urmatoare
compare_prio:
    cmp edi, eax
    jge end_compare_prio

    ;; memoram in esi campul .prio al elementului j
    movzx esi, byte[edx + edi + 2]
    ;; se compara valoare elementul i cu valoarea elementului j
    cmp ebx, esi 
    ;; daca ebx <= esi, inseamna ca prioritatile sunt ordonate crescator
    ;; deci continuam compararea
    jle continue_compare_prio

    ;; altfel, valorile tuturor celor 3 campuri, .prio, .time, .pid
    ;; trebuie interschimbate
    movzx ebx, byte[edx + ecx + 2]
    xchg bl, byte[edx + edi + 2]
    mov byte[edx + ecx + 2], bl

    mov bx, word[edx + ecx]
    xchg bx, word[edx + edi]
    mov word[edx + ecx], bx

    mov bx, word[edx + ecx + 3]
    xchg bx, word[edx + edi + 3]
    mov word[edx + ecx + 3], bx

    ;; restauram valoarea initiala a registrului ebx, respectiv
    ;; valoarea din campul .prio
    movzx ebx, byte[edx + ecx + 2]

;; daca nu am ajuns la finalul vectorului de structuri, 
;; trecem la urmatorul element j
continue_compare_prio:
    add edi, 5
    cmp edi, eax
    jl compare_prio

;; daca am ajuns la finalul listei pentru elementul j,
;; inseamna ca i a fost comparat cu toate elementele urmatoare din
;; sir, si putem sa ii crestem valoarea lui i
end_compare_prio:
    add ecx, 5
    cmp ecx, eax
    jl iterate

    ;; acum ca vectorul de structuri ordonat crescator dupa campul .prio
    ;; ne dorim sa il sortam si dupa campul .time
    mov eax, [ebp + 12]
    imul eax, 5
    xor ecx, ecx
    xor edi, edi
    xor esi, esi
    ;; parcurgem elementele vectorului de structuri
    jmp iterate2

swap:
    xor ebx, ebx
    xor esi, esi
    ;; in registrele ebx si esi vor fi memorate valorile
    ;; stocate in campurile .time pe pozitiile i si j
    movzx ebx, word[edx + ecx + 3]
    movzx esi, word[edx + edi + 3]

    cmp ebx, esi
    movzx ebx, byte[edx + ecx + 2]

    ;; daca acestea sunt deja ordonate crescator, ne intoarcem
    ;; in bucla noastra si trecem la urmatoarea valoare a lui j
    jle continue_compare_time

    ;; altfel, interschimbam valorile campurilor .time si .pid
    ;; si ulterior trecem la urmatoarea valoare a lui j
    mov bx, word[edx + ecx]
    xchg bx, word[edx + edi]
    mov word[edx + ecx], bx

    mov bx, word[edx + ecx + 3]
    xchg bx, word[edx + edi + 3]
    mov word[edx + ecx + 3], bx

    xor esi, esi
    movzx ebx, byte[edx + ecx + 2]
    jmp continue_compare_time

iterate2:
    ;; in registrul ebx, va fi stocata valoarea de pe pozitia
    ;; i din vectorul de structuri in campul .prio
    movzx ebx, byte[edx + ecx + 2]
    mov edi, ecx
    add edi, 5

compare_time:
    ;; daca am ajuns la finalul vectorului, jump la end_compare_time
    cmp edi, eax
    jge end_compare_time

    ;; in registrul esi, va fi stocata valoarea de pe pozitia
    ;; j din vectorul de structuri in campul .prio
    ;; i <= j si j <= numarul de elemente al vectorului
    movzx esi, byte[edx + edi + 2]
    cmp ebx, esi 

    ;; daca cele doua valori sunt egale, continuam compararea
    je swap

;; incrementam indicele j, trecand la urmatorul element din vectorul de 
;; structuri
continue_compare_time:
    add edi, 5
    cmp edi, eax
    jl compare_time

end_compare_time:
    add ecx, 5
    cmp ecx, eax
    ;; daca am iterata prin toate valorile pe care le poate lua j
    ;; trecem la urmatoarea valoare a lui i
    jl iterate2

    ;; vectorul este sortat corespunzator pentru campurile .prio si .time
    ;; ne dorim ca si valorile din campul .pid sa fie in ordine crescatoare

    mov eax, [ebp + 12]
    imul eax, 5
    xor ecx, ecx
    xor edi, edi
    xor esi, esi
    jmp iterate3

;; stim ca valorile din .prio sunt egale si continuam compararea
test_time:
    xor ebx, ebx
    xor esi, esi
    movzx ebx, word[edx + ecx + 3]
    movzx esi, word[edx + edi + 3]

    cmp ebx, esi
    movzx ebx, byte[edx + ecx + 2]
    ;; daca valorile din campurile .time nu sunt egale, jump la 
    ;; continue_compare_pid
    jne continue_compare_pid

    xor ebx, ebx
    xor esi, esi
    movzx ebx, word[edx + ecx]
    movzx esi, word[edx + edi]

    cmp ebx, esi
    movzx ebx, byte[edx + ecx + 2]
    ;; daca valorile din campurile .pid sunt deja ordonate crescatoar,
    ;; jump la continue_compare_pid
    jle continue_compare_pid

    ;; altfel, interschimbam valorile campului .pid si ulterior
    ;; trecem la urmatorul element
    mov bx, word[edx + ecx]
    xchg bx, word[edx + edi]
    mov word[edx + ecx], bx

    xor esi, esi
    movzx ebx, byte[edx + ecx + 2]
    jmp continue_compare_pid

;; parcurgem vectorul pentru a ordona si campul .pid
iterate3:
    ;; in ebx este memorata valoarea campului .prio al elementului de pe 
    ;; pozitia i
    movzx ebx, byte[edx + ecx + 2]
    mov edi, ecx
    add edi, 5

compare_pid:
    cmp edi, eax
    jge end_compare_pid

    ;; in esi este memorata valoarea campului .prio al elementului de pe 
    ;; pozitia j
    movzx esi, byte[edx + edi + 2]
    cmp ebx, esi

    ;; daca in campul prio valorile sunt egale, continuam compararea
    je test_time

;; crestem indicele j si continuam compararea cu i, pana cand ajungem la
;; finalul vectorului
continue_compare_pid:
    add edi, 5
    cmp edi, eax
    jl compare_pid

;; daca nu am ajuns la final, crestem valoarea indicelui i si continuam 
;; compararea
end_compare_pid:
    add ecx, 5
    cmp ecx, eax
    jl iterate3

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY