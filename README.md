# Programarea calculatoarelor si limbaje de programare 2 - Tema 2

Student: Andronache Madalina-Georgiana
Grupa: 312CC

Urmatorul fisier contine informatii despre rezolvarea taskurilor propuse in 
tema 2 de la PCLP2. Punctajul obtinut la testarea locala este de 100 de puncte.

Cea mai mare provocare intalnita a fost rezolvarea corecta si cat mai eficienta
a problemelor propuse intr-un timp cat mai scurt. Aceasta tema a fost rezolvata
pe parcursul a 7 zile: in total am lucrat la aceasta tema 31 h, dintre care 2 h
fiind necesare pentru scrierea fisierului README, 2.5 h pentru scrierea 
comentariilor, iar restul pentru codare. In viitor, imi doresc rezolvarea 
mai rapida a cerintelor. 

Cuprins:
1. Task 1
2. Task 2
3. Task 3
4. Task 4
5. Bonus

# 1. Task 1

Acest task a fost cel mai usor dupa parerea mea, rezolvarea lui necesitand
cel mai putin timp. Am avut de implementat functia cu antetul:
void simple(int n, char* plain, char* enc_string, int step); in care fiecare 
litera din textul plain este shiftata la dreapta in cadrul alfabetului de 
steps ori. 

* Implementare: 
Pentru fiecare caracter din cadrul lui plain (string-ul care trebuie criptat)
am adaugat la codul ascii al acestuia steps. Daca aceasta operatie, ducea la 
depasirea cadrului alfabetului, atunci, transformam caracterul in litera 
corespunzatoare, atunci cand alfabetul este considerat circular. Apoi, pentru 
fiecare element transformat corespunzator, acesta este scris la adresa 
enc_string (adresa la care se va scrie textul criptat), pe pozitia 
corespunzatoare.

# 2. Task 2

Implementarea acestui task mi-a luat cel mai mult, reusind sa rezolv cele 2 
cerinte in aproximativ 10 h si jumatate. Acest task are 2 parti: prima parte 
in care se implementeaza functia void sort_procs(struct proc *procs, int len)
care sorteaza un vector de structuri in urmatorul mod: crescator dupa al 
doilea camp, prio. Pentru procesele cu aceeasi prioritate, crescator dupa al 
treilea camp, time, iar la final, pentru procese cu aceeasi prioritate si cu 
aceeasi cuanta de timp, acestea vor fi ordonate crescator dupa id, deci dupa 
primul camp. In partea a doua, se implementeaza functia 
void run_procs(struct proc* procs, int len, struct avg *avg_out); in care
vom calcula intr-un mod simplificat timpul mediu de rulare pentru fiecare 
prioritate, adica va trebui sa calculati suma cuantelor de timp pentru o 
prioritate si apoi sa o impartiti la numarul de procese care au acea 
prioritate.

* Implementare partea 1: 
In aceasta functie se implementeaza metoda de sortare bubble sort, practic, 
fiecare element de pe o pozitie i, de la 1 <= i <= n - 1, este comparat cu 
fiecare elemente de pe pozitia j, unde i + 1 <= j <= n. Initial sortez 
vectorul de structuri dupa campul prio in ordine crescatoare.
De fiecare daca cand gasesc un element pentru care valoarea din campul prio 
este mai mare pe pozitia i, decat cel de pe pozitia j, interschimb toate cele
trei campuri ale structurii. Ulterior, cand aceasta sortare este finalizata,
ne dorim sa sortam conform enuntului, dupa campul time. Parcurgem din nou de 
la inceput vectorul de structuri si atunci cand valoarea din campul prio este
egala, ne dorim sa sortam dupa campul time. Folosind tot metoda bubble sort,
atunci cand gasim un element pentru care valoarea din campul prio este mai 
mare pe pozitia i, decat cel de pe pozitia j, interschimb campurile time si 
pid. Dupa ce aceasta sortare se termina, ne dorim sa sortam si dupa campul pid.
Parcurgem din nou, folosind tot bubble sort si atunci cand atat campul prio,
cat si campul time sunt egale realizam interschimbarea. 

* Implementare partea 2:
In vectorii globali, prio_result si time_result, vom memora urmatoare: pentru
fiecare valoare a prioritatii de la 1 la 5, in vectorul time_result pe pozitia
corespunzatoare valorii prioritatii - 1, se va calcula suma valorilor din 
campul time pentru accea prioritate. In acelasi timp, in vectorul prio_result
se va memora numarul de aparitii al unei prioritati de la 1 la 5, pe pozitia
corespunzatoare valorii prioritatii - 1, in vectorul de structuri. Ulterior,
completam structura avg, unde quo reprezinta catul impartirii si remain, 
restul impartirii lui time_result[i] si prio_result[i], unde i are valori 
intre 0 si 4.

# 3. Task 3

Din punctul meu de vedere acesta a fost cel mai greu task si am reusit sa 
rezolv doar prima parte a lui. La a doua parte am avut probleme in a 
intelege exact cum functioneaza mecanismul de criptare. In prima parte,
in functie de rotor, de sensul de rotatie al acestuia si de offsetul primit,
va trebui sa modificam 2 linii din matricea config.

* Implementare partea 1:
Prima oara, selectam sensul de rotatie: dreapta sau stanga. Ulterior, 
verificam si numarul rotorului. In functie de numarul rotorului, calculam 
adresa de unde incepe linia respectiva. Prima oara, retinem configuratia 
initiala a liniei pe care vrem sa o schimbam. Dupa, rotim cu x pozitii 
literele la stanga sau la dreapta. Completam pozitiile care nu corespund 
dupa rotire folosindu-ne de vectorul in care am memorat configuratia 
initiala. 

# 4. Task 4

Acest task mi s-a parut de dificultate medie, reusind sa il rezolv in 2 ore.
Dandu-se pozitia unei dame pe o tabla 8x8, dorim sa aflam pozitiile unde se 
poate deplasa. Trebuie sa scriem o functie cu urmatorul antet:
void checkers(int x, int y, char table[8][8]), unde x si y reprezinta
coordonatele de la inceput, pozitia initiala a damei, iar table, matricea
ce reprezinta tabla de joc.

* Implementare: 
Pentru inceput, am considerat urmatoarele cazuri: linia 1, linia 8, coloana 1,
coloana 8 si intersectiile lor, adica colturile matricei. Daca dama se afla 
intr-un colt al matricei, inseamna ca dama se va putea deplasa doar intr-o noua 
pozitie. In schimb, daca se afla pe linia 1, linia 8, coloana 1 sau coloana 8,
atunci dama se poate deplasa in 2 noi pozitii. Daca nici unul dintre aceste 
cazuri nu este indeplinit, atunci dama se afla in oricare alta pozitie, deci 
se va putea deplasa in 4 noi pozitii: stanga sus, stanga jos, dreapta sus, 
dreapta jos, pe diagonala. Aceste 4 pozitii se calculeaza usor, in functie de 
x si y, coordonatele initiale.

# 5. Bonus

Problema Bonus este o varianta optimizata a task-ului 4, intr-un cat in 
loc sa stocam intr-o matrice 8x8, vom folosi bitboard. Antetul functiei este:
void bonus(int x, int y, int board[2]), unde board[0] va reprezenta gruparea 
logica a primilor 32 de biti din matrice, deci partea de sus si board[1], 
ultimii 32 de biti din matrice, deci partea de jos.

* Implementare:
Initial, m-am gandit sa ma folosesc de task-ul 4 si sa folosesc o variabila 
globala in care sa stochez configuratia matricii table, insa, datorita 
faptului ca primeam warninguri, am cautat alta metoda de rezolvare. Atfel, 
am considerat cazurile anterioare: linia 1, linia 8, coloana 1, coloana 8, 
intersectiile acestora si in plus, am verificat daca dama se afla in partea de
sus sau de jos a matricei. Pentru fiecare noua pozitie a damei, am shiftat 1 la
stanga fix pana a ajuns pe pozitia dorita, considerand de fiecare data daca 
pozitia apartine lui board[0] sau board[1]. In plus, la aceste cazurii am 
adaugat urmatoarele 2: linia 4 si linia 5, deoarece atunci cand dama se afla 
pe una dintre aceste 2 linii, va avea 2 vecini care apartin lui board[0]
si 2 vecini care apartin lui board[1].
