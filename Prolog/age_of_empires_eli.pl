% Base de Conocimientos

% jugador(Nombre, Rating, Civilizacion).
jugador(juli, 2200, jemeres).
jugador(aleP, 1600, mongoles).
jugador(feli, 500000, persas).
jugador(aleC, 1723, otomanos).
jugador(ger, 1729, ramanujanos).
jugador(juan, 1515, britones).
jugador(marti, 1342, argentinos).

% tiene(Nombre, QueTiene).
tiene(aleP, unidad(samurai, 199)).
tiene(aleP, unidad(espadachin, 10)).
tiene(aleP, unidad(granjero, 10)).
tiene(aleP, recurso(800, 300, 100)).
tiene(aleP, edificio(casa, 40)).
tiene(aleP, edificio(castillo, 1)).
tiene(juan, unidad(carreta, 10)).

% militar(Tipo, costo(Madera, Alimento, Oro), Categoria).
militar(espadachin, costo(0, 60, 20), infanteria).
militar(arquero, costo(25, 0, 45), arqueria).
militar(mangudai, costo(55, 0, 65), caballeria).
militar(samurai, costo(0, 60, 30), unica).
militar(keshik, costo(0, 80, 50), unica).
militar(tarcanos, costo(0, 60, 60), unica).
militar(alabardero, costo(25, 35, 0), piquero).

% aldeano(Tipo, produce(Madera, Alimento, Oro)).
aldeano(lenador, produce(23, 0, 0)).
aldeano(granjero, produce(0, 32, 0)).
aldeano(minero, produce(0, 0, 23)).
aldeano(cazador, produce(0, 25, 0)).
aldeano(pescador, produce(0, 23, 0)).
aldeano(alquimista, produce(0, 0, 25)).

% edificio(Edificio, costo(Madera, Alimento, Oro)).
edificio(casa, costo(30, 0, 0)).
edificio(granja, costo(0, 60, 0)).
edificio(herreria, costo(175, 0, 0)).
edificio(castillo, costo(650, 0, 300)).
edificio(maravillaMartinez, costo(10000, 10000, 10000)).

% ------------------ Puntos ---------------------
juega(Jugador):-
    jugador(Jugador, _, _).

% ------------- Punto 1
esUnAfano(Jugador1, Jugador2) :-
    jugador(Jugador1, Rating1, _),
    jugador(Jugador2, Rating2, _),
    Rating1 - Rating2 > 500.

% ------------- Punto 2
esEfectivo(militar(_,_, caballeria), militar(_,_, arqueria)).
esEfectivo(militar(_,_, arqueria), militar(_,_, infanteria)).
esEfectivo(militar(_,_, infanteria), militar(_,_, piquero)).
esEfectivo(militar(_,_, piquero), militar(_,_, caballeria)).
esEfectivo(militar(samurai,_, unica), militar(_,_, unica)).
esEfectivo(_, aldeano(_,_)).

% ------------- Punto 3
alarico(Jugador) :-
    juega(Jugador),
    tiene(Jugador, _),
    forall(tiene(Jugador, unidad(Unidad, _)), militar(Unidad, _ , infanteria)).

% ------------- Punto 4
leonidas(Jugador) :-
    juega(Jugador),
    tiene(Jugador, _),
    forall(tiene(Jugador, unidad(Unidad, _)), militar(Unidad, _ , piqueros)).

% ------------- Punto 5
nomada(Jugador) :-
    juega(Jugador),
    not(tiene(Jugador, edificio(casa, _))).

% ------------- Punto 6
cuantoCuesta(edificio(_, Costo), Costo).
cuantoCuesta(militar(_, Costo, _), Costo).
cuantoCuesta(aldeano(_,_),costo(0,50,0)).
cuantoCuesta(carreta, costo(100,0,50)).
cuantoCuesta(urna, costo(100,0,50)).

% ------------- Punto 7
produccion(Unidad, Produccion):-
    aldeano(Unidad, Produccion).

produccion(carreta, produce(0,0,32)).
produccion(urna, produce(0,0,32)).
produccion(keshik, produce(0,0,10)).

produccion(militar(Tipo, _, _), produce(0,0,0)):-
    Tipo \= keshik.

% ------------- Punto 8
produccionTotal(Jugador, Produccion, Recurso) :-
    juega(Jugador),
    findall(ProdMadera, 
        (tiene(Jugador, unidad(Recurso, CantUnidades)), produccion(Recurso, produce(ProdMadera * CantUnidades,_,_))), 
        ProdsMadera),
    findall(ProdAlimento, 
        (tiene(Jugador, unidad(Recurso, CantUnidades)), produccion(Recurso, produce(_,ProdAlimento * CantUnidades,_))), 
        ProdsAlimento),
    findall(ProdOro, 
        (tiene(Jugador, unidad(Recurso, CantUnidades)), produccion(Recurso, produce(_,_,ProdOro * CantUnidades))), 
        ProdsOro),

    sumlist(ProdsMadera, ProduccionM),
    sumlist(ProdsOro, ProduccionO),
    sumlist(ProdsAlimento, ProduccionA),
    Produccion = produce(ProduccionM, ProduccionA, ProduccionO).

% ------------- Punto 9
estaPeleando(Jugador1, Jugador2):-
    not(esUnAfano(Jugador1,Jugador2)),
    not(esUnAfano(Jugador2,Jugador1)),
    
    sumaUnidades(Jugador1, CantUnids),
    sumaUnidades(Jugador2, CantUnids),

    valorTotal(Jugador1, ValorTotal1),
    valorTotal(Jugador2, ValorTotal2),

    abs(ValorTotal1 - ValorTotal2, Valor),
    Valor < 100.

sumaUnidades(Jugador, Total) :-
    findall(Cant, tiene(Jugador, unidad(_, Cant)), Cantidades),
    sumlist(Cantidades, Total).

valorTotal(Jugador, ValorTotal) :-
    findall(ProduM, (tiene(Jugador, Recurso), produccionTotal(Jugador, produce(ProduM, _, _), Recurso)), ProdsM),
    findall(ProduA, (tiene(Jugador, Recurso), produccionTotal(Jugador, produce(_, ProduA, _), Recurso)), ProdsA),
    findall(ProduO, (tiene(Jugador, Recurso), produccionTotal(Jugador, produce(_, _, ProduO), Recurso)), ProdsO),
    sumlist(ProdsM, ProduccionM),
    sumlist(ProdsA, ProduccionA),
    sumlist(ProdsO, ProduccionO),
    ValorM is ProduccionM * 3,
    ValorA is ProduccionA * 2,
    ValorO is ProduccionO * 5,
    ValorTotal is ValorM + ValorA + ValorO.

% ------------- Punto 10
avanzaA(Jugador, edadMedia) :-
    juega(Jugador).

avanzaA(Jugador, edadFeudal) :-
    juega(Jugador),
    not(nomada(Jugador)),
    tiene(Jugador, recurso(_, Alimento, _)),
    Alimento > 500.

avanzaA(Jugador, edadCastillo) :-
    juega(Jugador),
    
    tiene(Jugador, recurso(_, Alimento, _)),
    Alimento > 800,
    
    tiene(Jugador, recurso(_, _, Oro)),
    Oro > 200,

    tiene(Jugador, edificio(herreria,_)).

avanzaA(Jugador, edadCastillo) :-
    juega(Jugador),
    
    tiene(Jugador, recurso(_, Alimento, _)),
    Alimento > 800,
    
    tiene(Jugador, recurso(_, _, Oro)),
    Oro > 200,
    
    tiene(Jugador, edificio(establo,_)).

avanzaA(Jugador, edadCastillo) :-
    juega(Jugador),
    
    tiene(Jugador, recurso(_, Alimento, _)),
    Alimento > 800,
    
    tiene(Jugador, recurso(_, _, Oro)),
    Oro > 200,
    
    tiene(Jugador, edificio(galeriaDeTiro,_)).

avanzaA(Jugador, edadImperial) :-
    juega(Jugador),

    tiene(Jugador, recurso(_, Alimento, _)),
    Alimento > 1000,
    
    tiene(Jugador, recurso(_, _, Oro)),
    Oro > 800,

    tiene(Jugador, edificio(castillo,_)),
    tiene(Jugador, edificio(universidad,_)).
