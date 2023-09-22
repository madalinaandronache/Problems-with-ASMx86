%include "../include/io.mac"

;; defining constants, you can use these as immediate values in your code
LETTERS_COUNT EQU 26

section .data
    extern len_plain
    myVect:    times 50    db 0

section .text
    global rotate_x_positions
    global enigma
    extern printf

; void rotate_x_positions(int x, int rotor, char config[10][26], int forward);
rotate_x_positions:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; x
    mov ebx, [ebp + 12] ; rotor
    mov ecx, [ebp + 16] ; config (address of first element in matrix)
    mov edx, [ebp + 20] ; forward
    ;; DO NOT MODIFY
    ;; TODO: Implement rotate_x_positions
    ;; FREESTYLE STARTS HERE

    cmp edx, 0
    je left ; rotire la stanga
    cmp edx, 1
    je right ; rotire la dreapta 

;; selectam numarul corespunzator rotorului
left:
    cmp ebx, 0
    je rotor0_l

    cmp ebx, 1
    je rotor1_l

    cmp ebx, 2
    je rotor2_l

;; memoram in variabila globala myVect ordinea initiala inainte de rotire
vector:
    mov dl, byte[ecx + ebx]
    mov byte[myVect + ebx], dl
    inc ebx
    cmp ebx, LETTERS_COUNT
    jl vector
    jge back_r0

;; rotim la stanga cu x pozitii
rotate_left:
    add eax, edx
    mov bl, byte[ecx + eax]
    sub eax, edx
    mov byte[ecx + edx], bl
    inc edx
    cmp edx, esi
    jl rotate_left
    jge back_r1

;; completam pozitiile care nu corespund dupa rotire
complete:
    mov ebx, 0    
    mov bl, byte[myVect + edx]
    mov byte[ecx + esi], bl
    inc edx
    inc esi
    cmp esi, LETTERS_COUNT
    jl complete
    cmp edi, 0
    je back_r2
    cmp edi, 1
    je final

;; se calculeaza adresa de la care incepe primul element de pe prima linie
;; a rotorului 2
rotor1_l:
    add ecx, 52
    jmp rotor0_l

;; se calculeaza adresa de la care incepe primul element de pe prima linie
;; a rotorului 3
rotor2_l:
    add ecx, 104
    jmp rotor0_l

;; se calculeaza adresa de la care incepe primul element de pe prima linie
;; a rotorului 1
rotor0_l:
    cmp eax, 0
    je final
    xor ebx, ebx ; contor parcurgere linie 
    xor edx, edx ; element curent matrice
    mov edi, 0
    jmp vector
back_r0:
        ;; daca avem elementele salvate in variabila myVect, ne dorim
        ;; sa le rotim cu x pozitii
        xor ebx, ebx
        xor edx, edx
        mov esi, LETTERS_COUNT
        sub esi, eax
        jmp rotate_left
back_r1:
        ;; ultimele elemente de pe linie nu corespund, si le inlocuim cu
        ;; cele initiale din variabila myVect
        mov esi, edx
        xor edx, edx
        jmp complete
back_r2: 
        ;; daca ajungem in acest punct, trebuie sa efectuam operatiile
        ;; si asupra liniei 2 a rotorului
        add ecx, 26
        xor ebx, ebx
        xor edx, edx
        mov edi, 1        
        jmp vector

;; selectam numarul corespunzator rotorului
right:
    cmp ebx, 0
    je rotor0_r

    cmp ebx, 1
    je rotor1_r

    cmp ebx, 2
    je rotor2_r

;; memoram in variabila globala myVect ordinea initiala inainte de rotirea 
;; la dreapta
vector2:
    mov dl, byte[ecx + ebx]
    mov byte[myVect + ebx], dl
    inc ebx
    cmp ebx, LETTERS_COUNT
    jl vector2
    jge back_r0_l
    
;; rotim la dreapta cu x pozitii
rotate_right:
    mov bl, byte[ecx + esi]
    mov byte[ecx + edx], bl
    dec edx
    dec esi
    cmp esi, 0
    jge rotate_right
    jl back_r1_l

;; completam pozitiile care nu corespund dupa rotire
complete2:
    mov ebx, 0    
    mov bl, byte[myVect + esi]
    mov byte[ecx + edx], bl
    inc esi
    inc edx 
    cmp esi, LETTERS_COUNT
    jl complete2
    cmp edi, 0
    je back_r2_l
    jg final

;; se calculeaza adresa de la care incepe primul element de pe prima linie
;; a rotorului 2
rotor1_r:
    add ecx, 52
    jmp rotor0_r

;; se calculeaza adresa de la care incepe primul element de pe prima linie
;; a rotorului 3
rotor2_r:
    add ecx, 104
    jmp rotor0_r
;; se calculeaza adresa de la care incepe primul element de pe prima linie
;; a rotorului 1
rotor0_r:
    cmp eax, 0
    je final
    xor ebx, ebx ; contor parcurgere linie 
    xor edx, edx ; element curent matrice
    mov edi, 0; linia 2
    jmp vector2
back_r0_l:
        ;; daca avem elementele salvate in variabila myVect, ne dorim
        ;; sa le rotim cu x pozitii
        xor ebx, ebx
        xor edx, edx
        mov esi, LETTERS_COUNT
        mov edx, LETTERS_COUNT
        sub edx, 1
        sub esi, eax
        sub esi, 1
        jmp rotate_right
back_r1_l:
        ;; primele elemente de pe linie nu corespund, si le inlocuim cu
        ;; cele initiale din variabila myVect
        mov esi, LETTERS_COUNT
        xor edx, edx
        sub esi, eax
        jmp complete2
back_r2_l:           
        ;; daca ajungem in acest punct, trebuie sa efectuam operatiile
        ;; si asupra liniei 2 a rotorului
        add ecx, 26
        xor ebx, ebx
        xor edx, edx
        mov edi, 1        
        jmp vector2

final:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

; void enigma(char *plain, char key[3], char notches[3], char config[10][26], char *enc);
enigma:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; plain (address of first element in string)
    mov ebx, [ebp + 12] ; key
    mov ecx, [ebp + 16] ; notches
    mov edx, [ebp + 20] ; config (address of first element in matrix)
    mov edi, [ebp + 24] ; enc
    ;; DO NOT MODIFY
    ;; TODO: Implement enigma
    ;; FREESTYLE STARTS HERE


    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY