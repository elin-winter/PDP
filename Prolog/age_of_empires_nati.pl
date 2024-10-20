% Aquí va el código.
%Base de conocimientos

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

% edificio(Edificio, costo(Madera, Alimento, Oro)).
edificio(casa, costo(30, 0, 0)).
edificio(granja, costo(0, 60, 0)).
edificio(herreria, costo(175, 0, 0)).
edificio(castillo, costo(650, 0, 300)).
edificio(maravillaMartinez, costo(10000, 10000, 10000)).


%Punto 1

esUnAfano(Jugador1, Jugador2):-
    jugador(Jugador1,Rating1, _),
    jugador(Jugador2,Rating2, _),
    Diferencia is Rating1 - Rating2,
    Diferencia > 500.


%Punto 2

unidades(militar(_,_,_)).
unidades(aldeano(_,_)).

esEfectivo(Unidad1, Unidad2):-
    unidades(Unidad1),
    unidades(Unidad2),
    puedeGanarle(Unidad1, Unidad2).

puedeGanarle(militar(_,_, caballeria), militar(_,_, arqueria)).
puedeGanarle(militar(_,_, arqueria), militar(_,_, infanteria)).
puedeGanarle(militar(_,_, infanteria), militar(_,_, piquero)).
puedeGanarle(militar(_,_, piquero), militar(_,_, caballeria)).
puedeGanarle(militar(samurai,_,_), militar(_,_, unica)).
puedeGanarle(militar(_,_,_), aldeano(_,_)).


%Punto 3

alarico(Jugador):-
    jugador(Jugador, _, _),
    tiene(Jugador, _),
    forall(tiene(Jugador, unidad(Unidad, _)), esUnidadInfanteria(Unidad)).

esUnidadInfanteria(Unidad):-
    militar(Unidad, _, infanteria).

%Punto 4

leonidas(Jugador):-
    jugador(Jugador, _, _),
    tiene(Jugador, _),
    forall(tiene(Jugador, unidad(Unidad, _)), esUnidadPiquero(Unidad)).

esUnidadPiquero(Unidad):-
    militar(Unidad, _, piquero).


%Punto 5

nomada(Jugador):-
    jugador(Jugador, _, _),
    tiene(Jugador, _),
    not(tiene(Jugador, edificio(casa,_))).


%Punto 6

cuantoCuesta(Unidad, Costo):-
    esUnidadOEdificio(Unidad),
    definirCosto(Unidad, Costo).

esUnidadOEdificio(Unidad):-
    militar(Unidad, _, _);
    edificio(Unidad, _);
    aldeano(Unidad, _).

definirCosto(Unidad, Costo):-
    militar(Unidad, Costo, _).

definirCosto(Unidad, Costo):-
    edificio(Unidad, Costo).

definirCosto(Unidad, costo(0,50,0)):-
    aldeano(Unidad, _).

definirCosto(carreta, costo(100, 0, 50)).
definirCosto(urnaMercante, costo(100, 0, 50)).



%Punto 7

produccion(Unidad, Produccion):-
    unidades(Unidad),
    produccionTipoUnidad(Unidad, Produccion).

produccionTipoUnidad(militar(Tipo, _, _), produce(0,0,0)):-
    Tipo \= keshik.

produccionTipoUnidad(militar(keshik,_, _), produce(0,0,10)).

produccionTipoUnidad(aldeano(_, Produccion), Produccion).

produccionTipoUnidad(carreta, produce(0,0,32)).
produccionTipoUnidad(urnaMercante, produce(0,0,32)).

%Punto 8

recursos(madera).
recursos(oro).
recursos(alimento).

produccionTotal(Jugador,Recurso, ProduccionTotal):-
    jugador(Jugador, _, _),
    recursos(Recurso),
    findall(ProduccionUnidad, elementoProduce(Jugador, ProduccionUnidad), ProduccionUnidades),
    sum_list(ProduccionUnidades, ProduccionTotal). % ????

elementoProduce(Jugador, ProduccionUnidad):-
    tiene(Jugador, Unidad),
    Unidad \= recurso(_,_,_),
    produccion(Unidad, ProduccionUnidad).


%Punto 9
estaPeleado(Jugador1, Jugador2):-
    jugador(Jugador1,Rating1, _),
    jugador(Jugador2,Rating2, _),
    not(esUnAfanoParaAmbos(Jugador1, Jugador2)),
    tienenMismaCantidadUnidades(Jugador1, Jugador2),
    diferenciaMenorA100(Jugador1, Jugador2).

esUnAfanoParaAmbos(Jugador1, Jugador2):-
    esUnAfano(Jugador1, Jugador2).

esUnAfanoParaAmbos(Jugador1, Jugador2):-
    esUnAfano(Jugador2, Jugador1).

tienenMismaCantidadUnidades(Jugador1, Jugador2):-
    cantidadUnidades(Jugador1, Cantidad1),
    cantidadUnidades(Jugador2, Cantidad2),
    Cantidad1 = Cantidad2.

cantidadUnidades(Jugador, CantidadTotal):- 
    findall(Cantidad, tiene(Jugador, unidad(_,Cantidad)), Cantidades),
    sum_list(Cantidades, CantidadTotal).


diferenciaMenorA100(Jugador1, Jugador2):-
    calcularProduccionTotal(Jugador1, Total1),
    calcularProduccionTotal(Jugador2, Total2),
    Diferencia is Total1 - Total2,
    Diferencia < 100.


calcularProduccionTotal(Jugador, Total):-
    tiene(Jugador, recurso(_,_,_)),
    findall(Produccion, (recursos(Recurso), produccionRecurso(Jugador, Recurso, ProduccionTotal)), Producciones),
    sum_list(Producciones, Total).

produccionRecurso(Jugador, Recurso, ProduccionTotal):-
    tiene(Jugador, recurso(_,_, Oro)),
    produccionTotal(Jugador, Recurso, Produccion),
    multiplicadorRecurso(Recurso, Multiplicador),
    ProduccionTotal is Produccion * Multiplicador.

multiplicadorRecurso(oro, 5).
multiplicadorRecurso(alimento, 2).
multiplicadorRecurso(madera, 3).

%Punto 10

avanzaA(Jugador, Edad):-
    jugador(Jugador,_,_),
    puedeAvanzar(Jugador, Edad).

puedeAvanzar(_,edadMedia).
puedeAvanzar(Jugador, edadFeudal):-
    produccionMayorA(Jugador, alimento, 500),
    not(nomada(Jugador)).

puedeAvanzar(Jugador, edadCastillos):-
    produccionMayorA(Jugador, alimento, 800),
    produccionMayorA(Jugador, oro, 200),
    tieneEdificacion(Jugador).

puedeAvanzar(Jugador, edadImperial):-
    produccionMayorA(Jugador, alimento, 1000),
    produccionMayorA(Jugador, oro, 800),
    tiene(Jugador, edificio(castillo, _)),
    tiene(Jugador, edificio(universidad, _)).

produccionMayorA(Jugador, Recurso, Minimo):-
    tieneRecurso(Jugador, Recurso, Cantidad),
    Cantidad >= Minimo.

tieneRecurso(Jugador, oro, Cantidad):-
    tiene(Jugador, recurso(_,_, Cantidad)).

tieneRecurso(Jugador, alimento, Cantidad):-
    tiene(Jugador, recurso(_,Cantidad, _)).

tieneRecurso(Jugador, madera, Cantidad):-
    tiene(Jugador, recurso(Cantidad,_, _)).

tieneEdificacion(Jugador):-
    tiene(Jugador, edificio(herreria, _)).

tieneEdificacion(Jugador):-
    tiene(Jugador, edificio(establo, _)).

tieneEdificacion(Jugador):-
    tiene(Jugador, edificio(galeriaDeTiro, _)).
