section .data

section .text
	global checkers

checkers:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; table

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE

    ;; verificam daca ne aflam pe linia unu
    cmp eax, 0
    je line_one
    
    ;; verificam daca ne afla pe linia opt
    cmp eax, 7
    je line_eight

    ;; verificam daca ne afla pe coloana unu
    cmp ebx, 0
    je column_one

    ;; verificam daca ne aflam pe coloana opt
    cmp ebx, 7
    je column_eight

    ;; daca nici unul din cazurile de mai sus nu a fost indeplinit
    ;; inseamna ce ne aflam in interiorul tablei si dama se va putea
    ;; misca in 4 pozitii in orice caz
    
    add ecx, ebx
    mov edx, 1
    add ecx, 1
    sub eax, 1

    ;; pozitia dreapta sus (pe diagonala)
    mov byte[ecx + 8 * eax],  dl

    add eax, 2
    ;; pozitia dreapta jos (pe diagonala)
    mov byte[ecx + 8 * eax],  dl
    
    sub ecx, 2
    ;; pozitia stanga jos (pe diagonala)
    mov byte[ecx + 8 * eax],  dl

    sub eax, 2
    ;; pozitia stanga sus (pe diagonala)
    mov byte[ecx + 8 * eax],  dl

    jmp final

line_one_column_one:
    ;; dama se va putea misca doar in pozitia dreapta jos
    mov edx, 1

    add ebx, 1
    add eax, 1
    add ecx, ebx

    ;; pozitia dreapta jos (pe diagonala)
    mov byte[ecx + 8 * eax],  dl
    
    jmp final

line_one_column_eight:
    ;; dama se va putea misca doar in pozitia stanga jos
    mov edx, 1
    sub ebx, 1
    add eax, 1
    add ecx, ebx

    ;; pozitia stanga jos (pe diagonala)
    mov byte[ecx + 8 * eax],  dl

    jmp final

line_one:
    ;; jump la line_one_column_one daca aceasta este pozitia damei
    cmp ebx, 0
    je line_one_column_one

    ;; jump la line_one_column_eight daca aceasta este pozitia damei
    cmp ebx, 7
    je line_one_column_eight

    ;; daca niciunul dintre cazurile de mai sus nu este indeplinit
    ;; atunci, ne aflam pe o coloana diferita de 1 sau 8, deci dama
    ;; se va putea misca in 2 pozitii de fiecare data

    ;; folosim registru edx, pentru a stoca valoarea 1
    mov edx, 1

    sub ebx, 1
    add eax, 1
    add ecx, ebx

    ;; pozitia stanga jos (pe diagonala)
    mov byte[ecx + 8 * eax],  dl

    add ecx, 2
    ;; pozitia dreapta jos (pe diagonala)
    mov byte[ecx + 8 * eax],  dl

    jmp final

line_eight_column_one:
    ;; dama se va putea misca doar in pozitia dreapta sus
    mov edx, 1
    add ebx, 1
    sub eax, 1
    add ecx, ebx

    ;; poztia dreapta sus (pe diagonala)
    mov byte[ecx + 8 * eax],  dl

    jmp final

line_eight_column_eight:
    ;; dama se va putea misca doar in pozitia 
    mov edx, 1
    sub ebx, 1
    sub eax, 1
    add ecx, ebx

    ;; pozitia stanga sus (pe diagonala)
    mov byte[ecx + 8 * eax],  dl
    
    jmp final

line_eight:
    ;; daca coloana este 1, jump la line_eight_column_one
    cmp ebx, 0
    je line_eight_column_one

    ;; daca coloana este 8, jump la line_eight_column_eight
    cmp ebx, 7
    je line_eight_column_eight

    ;; daca niciunul dintre cazurile de mai sus nu este indeplinit
    ;; atunci, ne aflam pe o coloana diferita de 1 sau 8, deci dama
    ;; se va putea misca in 2 pozitii de fiecare data

    ;; stocam in edx valoarea 1
    mov edx, 1

    add ebx, 1
    sub eax, 1
    add ecx, ebx

    ;; pozitia dreapta sus (pe diagonala)
    mov byte[ecx + 8 * eax],  dl

    sub ecx, 2
    ;; pozitia stanga sus (pe diagonala)
    mov byte[ecx + 8 * eax],  dl
    jmp final

column_one:
    ;; daca ajungem in acest caz, inseamna ca numarul liniei 
    ;; este totusi diferit de unu sau de opt, deci, dama va puteam
    ;; merge in 2 pozitii de fiecare data

    mov edx, 1
    add ebx, 1
    sub eax, 1
    add ecx, ebx
    
    ;; pozitia dreapta sus (pe diagonala)
    mov byte[ecx + 8 * eax],  dl

    add eax, 2
    ;; pozitia dreapta jos (pe diagonala)
    mov byte[ecx + 8 * eax],  dl

    jmp final

column_eight:
    ;; daca ajungem in acest caz, inseamna ca numarul liniei 
    ;; este totusi diferit de unu sau de opt, deci, dama va puteam
    ;; merge in 2 pozitii de fiecare data

    mov edx, 1
    sub ebx, 1
    sub eax, 1
    add ecx, ebx

    ;; pozitia stanga sus (pe diagonala)
    mov byte[ecx + 8 * eax],  dl
    
    add eax, 2
    ;; pozitia stanga jos (pe diagonala)
    mov byte[ecx + 8 * eax],  dl
    jmp final    

final:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY