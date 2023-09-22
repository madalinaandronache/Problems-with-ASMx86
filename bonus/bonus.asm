section .data

section .text
    global bonus

bonus:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; board

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE
    
    ;; Selectam cazurile in functie de linie sau coloana
    cmp eax, 0
    je line_one
    
    cmp eax, 7
    je line_eight

    cmp ebx, 0
    je column_one 

    cmp ebx, 7
    je column_eight 

    cmp eax, 3
    je line_four

    cmp eax, 4
    je line_five

;; shiftam la stanga 1 de atatea ori, cat valoarea lui eax
shift_left:
    mov ebx, 1
    xor ecx, ecx
loop:
        shl ebx, 1
        inc ecx
        cmp ecx, eax
        jl loop
    jmp result_shift_left

;; calculam pozitia in care se poate misca dama si dam jump la shift_left
line_one_column_one:
    xor edx, edx
    add eax, 1
    mov edi, 8
    mul edi
    add eax, 1
    mov edx, 0
    jmp shift_left

;; calculam pozitia in care se poate misca dama si dam jump la shift_left
line_one_column_eight:
    xor edx, edx
    add eax, 1
    mov edi, 8
    mul edi
    add eax, ebx
    sub eax, 1
    mov edx, 0
    jmp shift_left 

;; daca linia este 1
line_one:
    ;; verificam coloana pe care ne aflam
    cmp ebx, 0
    je line_one_column_one  
    
    cmp ebx, 7
    je line_one_column_eight

    ;; daca nici unul din cazurile de mai sus nu este
    ;; indeplinit, inseamna ca ne aflam pe o coloana
    ;; diferita de 1 si 8
    xor edx, edx
    add eax, 1
    mov edi, 8
    mul edi
    add eax, ebx
    sub eax, 1
    mov edx, 1
    jmp shift_left

;; calculam pozitia in care se poate misca dama si dam jump la shift_left
line_eight_column_one:
    xor edx, edx
    sub eax, 4
    sub eax, 1
    mov edi, 8
    mul edi
    add eax, ebx
    add eax, 1
    mov edx, 3
    jmp shift_left

;; calculam pozitia in care se poate misca dama si dam jump la shift_left
line_eight_column_eight:
    xor edx, edx
    sub eax, 4
    sub eax, 1
    mov edi, 8
    mul edi
    add eax, ebx
    sub eax, 1
    mov edx, 3
    jmp shift_left   

;; daca linia este 8
line_eight:
    ;; verificam coloana pe care ne aflam
    cmp ebx, 0
    je line_eight_column_one

    cmp ebx, 7
    je line_eight_column_eight
    
    ;; daca nici unul din cazurile de mai sus nu este
    ;; indeplinit, inseamna ca ne aflam pe o coloana
    ;; diferita de 1 si 8
    xor edx, edx
    sub eax, 4
    sub eax, 1
    mov edi, 8
    mul edi
    add eax, ebx
    sub eax, 1
    mov edx, 4
    jmp shift_left

;; calculam pozitia in care se poate misca dama si dam jump la shift_left
column_one_up:
    xor edx, edx
    sub eax, 1
    mov edi, 8
    mul edi
    add eax, 1
    mov edx, 5 
    jmp shift_left

;; calculam pozitia in care se poate misca dama si dam jump la shift_left
column_one_down:
    xor edx, edx
    sub eax, 4
    sub eax, 1
    mov edi, 8
    mul edi
    add eax, 1
    mov edx, 6
    jmp shift_left

;; daca am ajuns in acest caz si ne aflam pe coloana 1, 
;; inseamna ca linia nu este 1 sau 8
column_one:
    ;; daca linia este in partea de sus a matricei sau in partea de jos
    cmp eax, 3
    jle column_one_up

    cmp eax, 4
    jge column_one_down               

;; calculam pozitia in care se poate misca dama si dam jump la shift_left
column_eight_up:
    xor edx, edx
    sub eax, 1
    mov edi, 8
    mul edi
    add eax, ebx
    sub eax, 1
    mov edx, 7     
    jmp shift_left

;; calculam pozitia in care se poate misca dama si dam jump la shift_left
column_eight_down:
    xor edx, edx
    sub eax, 4
    sub eax, 1
    mov edi, 8
    mul edi
    add eax, ebx
    sub eax, 1
    mov edx, 8    
    jmp shift_left

;; daca am ajuns in acest caz si ne aflam pe coloana 8, 
;; inseamna ca linia nu este 1 sau 8
column_eight:
    cmp eax, 3
    jle column_eight_up

    cmp eax, 4
    jge column_eight_down

;; pentru liniile 4 si 5, este un caz separat, deoarece exista 2 pozitii
;; care se adauga in partea de sus si 2 care sunt in partea de jos
line_four:
    ;; adaugam elementele din partea de sus
    xor edx, edx
    sub eax, 1
    mov edi, 8
    mul edi
    add eax, ebx
    sub eax, 1
    mov edx, 1 
    mov esi, 1               
    jmp shift_left

line_five:
    sub eax, 1
    mov edi, 8
    mul edi
    add eax, ebx
    sub eax, 1
    mov edx, 1
    mov esi, 1 
    jmp shift_left

;; adaugam elementele in partea de jos a matricei, board[1]
down_part:
    xor edx, edx
    mov eax, [ebp + 8]	
    mov ebx, [ebp + 12]	    
    add eax, 1
    sub eax, 4
    mov edi, 8
    mul edi
    add eax, ebx
    sub eax, 1
    mov edx, 4
    mov esi, 2 
    jmp shift_left


two_terms:
    xor edi, edi
    mov edi, ebx 
    add eax, 2
    mov edx, 10
    jmp shift_left

two_terms_down:
    mov edi, ebx
    add eax, 2
    mov edx, 11
    jmp shift_left

one_term:
    mov ecx, [ebp + 16] 
    mov dword[ecx + 4], ebx
    jmp final

one_term_down:
    mov ecx, [ebp + 16] 
    mov dword[ecx], ebx
    jmp final

two_terms_result_up:
    add edi, ebx
    mov ecx, [ebp + 16] 
    mov dword[ecx + 4], edi
    jmp final  

two_terms_result_down:
    add edi, ebx
    mov ecx, [ebp + 16]
    mov dword[ecx], edi
    jmp final

two_terms_column_one_up:
    mov edi, ebx
    mov eax, [ebp + 8]
    inc eax
    mov ebx, 8
    mul ebx
    add eax, 1
    mov edx, 10
    jmp shift_left

two_terms_column_one_down:
    mov edi, ebx
    mov eax, [ebp + 8]
    sub eax, 4
    inc eax
    mov ebx, 8
    mul ebx
    add eax, 1
    mov edx, 11
    jmp shift_left

two_terms_column_eight_up:
    mov edi, ebx
    mov eax, [ebp + 8]
    inc eax
    mov ebx, 8
    mul ebx
    mov ebx, [ebp + 12] 
    add eax, ebx
    sub eax, 1
    mov edx, 10
    jmp shift_left

two_terms_column_eight_down:
    mov edi, ebx
    mov eax, [ebp + 8]
    sub eax, 4
    inc eax
    mov ebx, 8
    mul ebx
    mov ebx, [ebp + 12]
    add eax, ebx
    sub eax, 1
    mov edx, 11    
    jmp shift_left

;; in functie de valoarea lui edx, selectam daca avem de adaugat
;; un termen, doi sau 4 si in ce parte a matricei sunt pozitiile
;; in care se poate duce dama
result_shift_left:
    cmp edx, 0
    je one_term

    cmp edx, 1
    je two_terms
    
    cmp edx, 3
    je one_term_down

    cmp edx, 4
    je two_terms_down

    cmp edx, 5
    je two_terms_column_one_up

    cmp edx, 6
    je two_terms_column_one_down

    cmp edx, 7
    je two_terms_column_eight_up

    cmp edx, 8
    je two_terms_column_eight_down

    cmp edx, 10
    je two_terms_result_up

    cmp edx, 11
    je two_terms_result_down

final:
    ;; daca valoarea din registru esi este 1, trebuie sa adaugam
    ;; valorile si in partea de jos a matricei
    cmp esi, 1
    je down_part

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY