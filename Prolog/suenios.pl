%%%%%%%%%%%%%%%%%%%%%%%%%%% Sueños %%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% Punto 1

creeEn(gabriel, campanita).
creeEn(gabriel, magoDeOz).
creeEn(gabriel, cavenagui).
creeEn(juan, conejoDePascua).
creeEn(macarena, reyesMagos).
creeEn(macarena, magoCapria).
creeEn(macarena, campanita).

suenia(gabriel, loteria([5,9])).
suenia(gabriel, futbol(arsenal)).
suenia(juan, cantante(100000)).
suenia(macarena, cantante(10000)).

% Principio de Universo Cerrado y Polimorfismo

%%%%%%%%%%%%%%%%%%%%%%% Punto 2

esAmbiciosa(Persona):-
    suenia(Persona, _),
    findall(Dificultad, dificultadSuenio(Persona, Dificultad), Dificultades),
    sumlist(Dificultades, Cant),
    Cant > 20.

dificultadSuenio(Persona, Dificultad):-
    suenia(Persona, Suenio),
    dificultad(Suenio, Dificultad).

dificultad(cantante(Cant), 6):-
    Cant > 500000.

dificultad(cantante(Cant), 4):-
    Cant =< 500000.

dificultad(loteria(Numeros), Dificultad):-
    length(Numeros, Cant),
    Dificultad is Cant * 10.

dificultad(futbol(Equipo), 3):-
    equipoChico(Equipo).

dificultad(futbol(Equipo), 16):-
    not(equipoChico(Equipo)).

equipoChico(arsenal).
equipoChico(aldosivi).

%%%%%%%%%%%%%%%%%%%%%%% Punto 3

quimica(campanita, Persona):-
    creeEn(Persona, campanita),
    suenia(Persona, Suenio),
    dificultad(Suenio, Dificultad),
    Dificultad < 5.

quimica(Personaje, Persona):-
    creeEn(Persona, Personaje),
    Personaje \= campanita,
    forall(suenia(Persona, Suenio), esPuro(Suenio)),
    not(esAmbiciosa(Persona)).

esPuro(futbol(_)).
esPuro(cantante(Cant)):-
    Cant < 200000.

%%%%%%%%%%%%%%%%%%%%%%% Punto 4

amigo(campanita, reyesMagos).
amigo(campanita, conejoDePascua).
amigo(conejoDePascua, cavenagui).

estaEnfermo(campanita).
estaEnfermo(reyesMagos).
estaEnfermo(conejoDePascua).

puedeAlegrar(Personaje, Persona):-
    suenia(Persona, _),
    quimica(Personaje, Persona),
    alguienNoEnfermo(Personaje).

alguienNoEnfermo(Personaje):-
    creeEn(_, Personaje),
    not(estaEnfermo(Personaje)).

alguienNoEnfermo(Personaje):-
    creeEn(_, Personaje),
    estaEnfermo(Personaje),
    amigo(Personaje, Otro),
    alguienNoEnfermo(Otro).


