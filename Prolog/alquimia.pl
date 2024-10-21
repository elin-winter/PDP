%%%%%%%%%%%%%%%%%%%%%%%%%%%% Alquimia %%%%%%%%%%%%%%%%%%%%%

% Los círculos alquímicos tienen diámetro en cms y cantidad de niveles.
% Las cucharas tienen una longitud en cms.
% Hay distintos tipos de libro.

herramienta(ana, circulo(50,3)).
herramienta(ana, cuchara(40)).
herramienta(beto, circulo(1,1)).
herramienta(beto, libro(inerte)).
herramienta(cata, libro(vida)).
herramienta(cata, circulo(100,5)).

%%%%%%%%%%%%%%%%%%%%%%%%%% Punto 1

tiene(ana, agua).
tiene(ana, vapor).
tiene(ana, tierra).
tiene(ana, hierro).
tiene(beto, Material) :-
    tiene(ana, Material).
tiene(cata, fuego).
tiene(cata, tierra).
tiene(cata, agua).
tiene(cata, aire).

construir(pasto, [agua, tierra]).
construir(hierro, [fuego, agua, tierra]).
construir(hueso, [pasto, agua]).
construir(presion, [hierro, vapor]).
construir(vapor, [agua, fuego]).
construir(playStation, [silicio, hierro, plastico]).
construir(silicio, [tierra]).
construir(plastico, [hueso, presion]).

jugador(Jugador):-
    tiene(Jugador, _).

elemento(Elemento):-
    construir(Elemento, _).

elemento(Elemento):-
    construir(_, Lista),
    member(Elemento, Lista).

%%%%%%%%%%%%%%%%%%%%%%%%%% Punto 2

tieneIngredientesPara(Jugador, Elemento):-
    jugador(Jugador),
    construir(Elemento, ListaNecesaria),
    forall(member(Ingrediente, ListaNecesaria), tiene(Jugador, Ingrediente)).

%%%%%%%%%%%%%%%%%%%%%%%%%% Punto 3

estaVivo(agua).
estaVivo(fuego).
estaVivo(E1):-
    construir(E1, Lista),
    member(E2, Lista),
    estaVivo(E2).

%%%%%%%%%%%%%%%%%%%%%%%%%% Punto 4
puedeConstruir(Persona, Elemento):-
    tieneIngredientesPara(Persona, Elemento),
    cuentaConElems(Persona, Elemento).

cuentaConElems(Persona, Elemento):-
    herramienta(Persona, Herramienta),
    necesita(Herramienta, Elemento).

necesita(libro(vida), Elemento):-
    estaVivo(Elemento).

necesita(libro(inerte), Elemento):-
    not(estaVivo(Elemento)).

necesita(circulo(Diametro, CantNiveles), Elemento):-
    cantElementos(Elemento, CantIngredientes),
    CantIngredientes =< (Diametro * CantNiveles).

necesita(cuchara(Long), Elemento):-
    cantElementos(Elemento, CantIngredientes),
    CantIngredientes =< Long/10.

cantElementos(Elemento, CantIngredientes):-
    construir(Elemento, ListaNecesaria),
    length(ListaNecesaria, CantIngredientes).

%%%%%%%%%%%%%%%%%%%%%%%%%% Punto 5

todopoderoso(Persona):-
    jugador(Persona),
    forall(primitivo(E1), tiene(Persona, E1)),
    forall((elemento(E2), not(tiene(Persona, E2))), cuentaConElems(Persona, E2)).

primitivo(Elemento):-
    elemento(Elemento),
    not(construir(Elemento, _)).

%%%%%%%%%%%%%%%%%%%%%%%%%% Punto 6

quienGana(Jugador):-
    jugador(Jugador),
    cantConstruida(Jugador, Max),
    forall(cantConstruida(_, Cant), Cant =< Max).

cantConstruida(Jugador, CantConstruida):-
    findall(Elemento, puedeConstruir(Jugador, Elemento), Elementos),
    length(Elementos, CantConstruida).

%%%%%%%%%%%%%%%%%%%%%%%%%% Punto 7

/*
Cuando la consigna decía "Cata no tiene vapor" no genere ningun hecho
en la base de conocimientos para cubrir esa información, ya que aquello que
no forma parte de ella ya se considera falso, porque la base de 
conocimientos de Prolog funciona con el Principio de Universo Cerrado (todo aquello
que no se coloque en ella se considera falso). De esta forma, si yo fuera a 
consultar si Cata tiene vapor, me diría "false".

?- tiene(cata, vapor).
false.

*/

%%%%%%%%%%%%%%%%%%%%%%%%%% Punto 8: Bonus

puedeLlegarATener(Jugador, Elemento):-
    tiene(Jugador, Elemento).

puedeLlegarATener(Jugador, Elemento):-
    elemento(Elemento),
    cuentaConElems(Jugador, Elemento),
    forall(requiere(Elemento, Ingrediente), puedeLlegarATener(Jugador, Ingrediente)).

requiere(Elemento, Ingrediente) :-
    construir(Elemento, Lista),
    member(Ingrediente, Lista).


