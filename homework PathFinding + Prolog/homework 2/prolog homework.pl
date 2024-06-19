% knowledge base per es 3
arc(a,b).
arc(a,c).
arc(b,d).
arc(b,e).
arc(c,b).
arc(e,c).



% ESERCIZIO 1
% a. Programma Prolog per calcolare N-esimo numero della successione di Fibonacci:
/*Le prime due clausole del predicato specificano che il primo numero di Fibonacci è 0 (fibonacci(0, 0)) e il secondo numero è 1 (fibonacci(1, 1)).
Questi sono i casi base della successione di Fibonacci.
La terza clausola fibonacci(N, F) gestisce i casi per N maggiore di 1. In questa clausola, viene effettuato il calcolo ricorsivo dei numeri di Fibonacci.
La clausola afferma che il N-esimo numero di Fibonacci è la somma del (N-1)-esimo numero e del (N-2)-esimo numero.
Quindi, vengono utilizzate le variabili N1 e N2 per rappresentare N-1 e N-2 rispettivamente. Successivamente, viene effettuata una chiamata ricorsiva a fibonacci(N1, F1)
e fibonacci(N2, F2) per ottenere i valori dei numeri precedenti. Infine, il risultato F viene calcolato come la somma di F1 e F2 tramite l'operatore is (F is F1 + F2).*/
fibonacci(0, 0).
fibonacci(1, 1).
fibonacci(N, F) :-
    N > 1,
    N1 is N - 1,
    N2 is N - 2,
    fibonacci(N1, F1),
    fibonacci(N2, F2),
    F is F1 + F2.


% b. Programma Prolog per verificare se un numero N è primo:
/*Le prime due clausole del predicato specificano che i numeri 2 e 3 sono considerati primi(casi base).
La terza clausola prime(N) gestisce i casi per N maggiore di 3. In questa clausola, vengono verificate due condizioni per determinare se N è un numero primo.
La prima condizione N mod 2 =\= 0 controlla se N è dispari, poiché i numeri pari maggiori di 2 non possono essere primi.
La seconda condizione \+ has_divisor(N, 3) verifica se N ha un divisore diverso da 1 e se stesso. Questa condizione utilizza il predicato ausiliario has_divisor
per verificare se N ha un divisore da 3 fino alla radice quadrata di N. Il predicato has_divisor è implementato in modo ricorsivo e controlla se N è divisibile per D,
se D è minore della radice quadrata di N e se N ha un divisore successivo a D.
Se entrambe le condizioni sono soddisfatte, N viene considerato un numero primo e il predicato restituirà true.
Altrimenti, se una delle condizioni non è soddisfatta, N viene considerato un numero non primo e il predicato restituirà false*/
prime(2).
prime(3).
prime(N) :-
    N > 3,
    N mod 2 =\= 0,  % Verifica se N è dispari
    \+ has_divisor(N, 3).

has_divisor(N, D) :-
    N mod D =:= 0.
has_divisor(N, D) :-
    D * D < N,
    D2 is D + 2,
    has_divisor(N, D2).



% ESERCIZIO 2
% a. Programma Prolog per calcolare il prodotto scalare tra due vettori:
/*La prima clausola cdot([], [], 0) è un caso base che stabilisce che il prodotto interno di due liste vuote è 0.
La seconda clausola cdot([X|V], [Y|W], XW) effettua il calcolo ricorsivo del prodotto scalare.
Viene utilizzata la ricorsione per calcolare il prodotto interno delle code delle liste V e W, ottenendo il risultato XY.
Successivamente, il risultato XW viene calcolato come il prodotto tra il primo elemento delle liste X e Y, sommato a XY tramite l'operatore is.*/
cdot([], [], 0).
cdot([X|V], [Y|W], XW) :-
    cdot(V, W, XY),
    XW is X * Y + XY.


% b. Programma Prolog per verificare se una lista è ripida:
/*La prima clausola steep([]) afferma che una lista vuota è considerata ripida(caso base).
La seconda clausola steep([_]) afferma che una lista con un solo elemento è considerata ripida(caso base).
La terza clausola steep([X,Y|L]) è la clausola ricorsiva principale. Questa clausola verifica se una lista ha il primo elemento X maggiore o uguale alla somma
degli elementi successivi nella lista L. Utilizza il predicato sum_list per calcolare la somma degli elementi nella lista L.
Se X è maggiore o uguale alla somma, allora la lista è considerata ripida. Successivamente, viene effettuata una chiamata ricorsiva a steep([Y|L])
per verificare il resto della lista.*/
steep([]).
steep([_]).
steep([X,Y|L]) :-
    sum_list(L, Sum),
    X >= Sum,
    steep([Y|L]).


% c. Programma Prolog per verificare se una lista è un segmento di una altra lista:
/*La clausola seg(S, L) utilizza il predicato predefinito append per dividere la lista L in tre parti:
-un prefisso anonimizzato(cioè non rilevante per il predicato, posso non specificarlo) append(_, SubList, L),
-la sottolista SubList,
-un suffisso anonimizzato append(S, _, SubList).
Il primo append(_, SubList, L) afferma che possiamo ottenere L dividendo la lista in un prefisso anonimizzato e la sottolista SubList.
E quindi SubList rappresenta una porzione di L.
Il secondo append(S, _, SubList) afferma che possiamo ottenere SubList dividendo la sottolista in S e un suffisso anonimizzato.
E quindi S rappresenta una sottosequenza di SubList.*/
seg(S, L) :-
    append(_, SubList, L),
    append(S, _, SubList).


% d. Programma Prolog per inserire un elemento in una lista mantenendo ordinamento:
/*La clausola isort(X, [], [X]). gestisce il caso base in cui la lista di input è vuota. In questo caso, il predicato restituisce semplicemente una lista contenente
l'elemento X come unica occorrenza.
Le clausole successive definiscono il passo ricorsivo dell'algoritmo di inserimento. L'idea principale è che l'elemento X viene inserito in modo appropriato
nella lista già ordinata [Y|L] per ottenere una nuova lista ordinata [X,Y|L]. La clausola X =< Y verifica se X è minore o uguale a Y. In tal caso, X viene inserito
prima di Y nella nuova lista.
Se X è maggiore di Y, la clausola successiva X > Y, isort(X, L, L1) viene utilizzata per continuare la ricerca di un punto di inserimento appropriato per X.
Questo viene fatto chiamando ricorsivamente isort sulla coda della lista [Y|L] per ottenere la lista ordinata L1. Successivamente, Y viene mantenuto come primo elemento
nella nuova lista L1.*/
isort(X, [], [X]).
isort(X, [Y|L], [X,Y|L]) :-
    X =< Y.
isort(X, [Y|L], [Y|L1]) :-
    X > Y,
    isort(X, L, L1).



% ESERCIZIO 3
% Programma Prolog per effettuare la visita depth-first di un grafo:
/*La clausola dfv(R, N) :- dfv_helper(R, [], N). definisce il punto di ingresso del predicato dfv. Riceve un argomento R che rappresenta il nodo di partenza e
un argomento N che rappresenta il nodo obiettivo. Richiama il predicato ausiliario dfv_helper passando il nodo di partenza R, una lista vuota [] per tracciare i nodi visitati
e l'argomento N come nodo obiettivo.
La clausola dfv_helper(Node, Visited, Node) :- \+ member(Node, Visited). gestisce il caso in cui il nodo corrente Node sia il nodo obiettivo Node stesso.
Verifica se il nodo corrente non è presente nella lista dei nodi visitati Visited. Se è vero, allora abbiamo trovato il percorso desiderato, e il predicato restituisce true.
Questa clausola è la base della ricorsione quando raggiungiamo il nodo obiettivo.
La clausola successiva dfv_helper(Node, Visited, N) :- \+ member(Node, Visited), arc(Node, Next), dfv_helper(Next, [Node|Visited], N). gestisce il caso generale in cui il nodo
corrente Node non è ancora il nodo obiettivo. Verifica se il nodo corrente non è presente nella lista dei nodi visitati Visited. Se è vero, trova un arco (arc(Node, Next)) che
connette il nodo corrente a un nodo successivo Next. Successivamente, richiama ricorsivamente dfv_helper passando il nodo successivo come nuovo nodo corrente,
aggiungendo il nodo corrente alla lista dei nodi visitati [Node|Visited], e l'argomento N come nodo obiettivo.*/
dfv(R, N) :-
    dfv_helper(R, [], N).

dfv_helper(Node, Visited, Node) :-
    \+ member(Node, Visited).
dfv_helper(Node, Visited, N) :-
    \+ member(Node, Visited),
    arc(Node, Next),
    dfv_helper(Next, [Node|Visited], N).
