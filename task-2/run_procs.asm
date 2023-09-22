%include "../include/io.mac"

struc avg
    .quo: resw 1
    .remain: resw 1
endstruc

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

    ;; Hint: you can use these global arrays
section .data
    prio_result dd 0, 0, 0, 0, 0
    time_result dd 0, 0, 0, 0, 0

section .text
    global run_procs

run_procs:
    ;; DO NOT MODIFY

    push ebp
    mov ebp, esp
    pusha

    xor ecx, ecx

clean_results:
    mov dword [time_result + 4 * ecx], dword 0
    mov dword [prio_result + 4 * ecx],  0

    inc ecx
    cmp ecx, 5
    jne clean_results

    mov ecx, [ebp + 8]      ; processes
    mov ebx, [ebp + 12]     ; length
    mov eax, [ebp + 16]     ; proc_avg
    ;; DO NOT MODIFY
   
    ;; Your code starts here

   xor edi, edi
    jmp iterate

;; daca valoarea campului .prio al structurii este 1
;; atunci valoarea campului .time este adaugat in vectorul time_result pe 
;; pozitia 0 si numarul de aparitii a prioritatii creste, aceasta fiind 
;; memorata pe pozitia 0 a vectorului prio_result
value_one:
    xor ebx, ebx
    inc dword[prio_result]
    movzx ebx, word[ecx + edi + 3]
    add dword[time_result], ebx
    mov ebx, [ebp + 12] 
    jmp back_iterate

;; analog ca la value_one, daca valoarea campului .prio al structurii
;; este 2, atunci valoarea este adaugata in time_result[1] si 
;; numarul de aparitii memorat prio_result[1] creste
value_two:
    xor ebx, ebx
    inc dword[prio_result + 4]
    movzx ebx, word[ecx + edi + 3]
    add dword[time_result + 4], ebx
    mov ebx, [ebp + 12] 
    jmp back_iterate

;; daca valoarea campului .prio al structurii este 3, 
;; atunci valoarea este adaugata in time_result[2] si 
;; numarul de aparitii memorat prio_result[2] creste
value_three:
    xor ebx, ebx
    inc dword[prio_result + 8]
    movzx ebx, word[ecx + edi + 3]
    add dword[time_result + 8], ebx
    mov ebx, [ebp + 12] 
    jmp back_iterate

;; daca valoarea campului .prio al structurii este 4, 
;; atunci valoarea este adaugata in time_result[3] si 
;; numarul de aparitii memorat prio_result[3] creste
value_four:
    xor ebx, ebx
    inc dword[prio_result + 12]
    movzx ebx, word[ecx + edi + 3]
    add dword[time_result + 12], ebx
    mov ebx, [ebp + 12] 
    jmp back_iterate  

;; daca valoarea campului .prio al structurii este 5, 
;; atunci valoarea este adaugata in time_result[4] si 
;; numarul de aparitii memorat prio_result[4] creste
value_five:
    xor ebx, ebx
    inc dword[prio_result + 16]
    movzx ebx, word[ecx + edi + 3]
    add dword[time_result + 16], ebx
    mov ebx, [ebp + 12] 
    jmp back_iterate  

;; parcurgem toate elementele dupa sortarea acestora din functia
;; sort_procs
iterate:
    xor esi, esi
    mov esi, edi
    imul edi, 5

    ;; in registrul edx memoram valoarea .prio a fiecarui element al
    ;; vectorului de structuri
    movzx edx, byte[ecx + edi + 2]

    mov ecx, 1
    cmp ecx, edx
    mov ecx, [ebp + 8]
    ;; daca valoarea este 1, atunci jump la value_one
    je value_one

    xor ecx, ecx
    mov ecx, 2
    cmp ecx, edx
    mov ecx, [ebp + 8]
    ;; daca valoarea este 2, atunci jump la value_two
    je value_two

    xor ecx, ecx
    mov ecx, 3
    cmp ecx, edx
    mov ecx, [ebp + 8]
    ;; daca valoarea este 3, atunci jump la value_three
    je value_three
   
    xor ecx, ecx
    mov ecx, 4
    cmp ecx, edx
    mov ecx, [ebp + 8]
    ;; daca valoarea este 4, atunci jump la value_four
    je value_four    

    xor ecx, ecx
    mov ecx, 5
    cmp ecx, edx
    mov ecx, [ebp + 8]
    ;; daca valoarea este 5, atunci jump la value_five
    je value_five    

;; trecem la elementul urmator
back_iterate:
    inc esi
    mov edi, esi
    cmp edi, ebx
    jl iterate

    xor edi, edi

loop_avg:
    mov ebx, [ebp + 16] ; adresa de inceput ptr avg
    xor eax, eax
    xor ecx, ecx
    xor edx, edx
    
    ;; calculam de fiecare data time_result[i] si prio_result[i]
    ;; unde i are valori de la 0 la 4
    mov eax, dword[time_result + 4 * edi]
    mov ecx, dword[prio_result + 4 * edi]

    ;; daca deimpartitul este 0, jump la case_zero
    cmp ecx, 0
    je case_zero
    
    ;; impartirea se poate efectua
    idiv ecx;

    ;; catul impartirii
    mov word[ebx + edi * 4], ax
    ;; restul impartirii
    mov word[ebx + edi * 4 + 2], dx

;; trecem la urmatorul element al vectorului de structuri agv, daca acest lucru 
;; este posibil
back_loop_avg:
    inc edi
    cmp edi, 5
    jl loop_avg
    je final

;; daca deimpartitul este 0, impartirea nu se poate efectua,
;; deci vom pune in avg.quo si avg.remain chiar valorile 
;; stocate in eax si ecx
case_zero:
    mov word[ebx + edi * 4], ax
    mov word[ebx + edi * 4 + 2], cx
    jmp back_loop_avg

;; am completat fiecare pozitie din agv
final:

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY