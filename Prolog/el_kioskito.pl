%%%%%%%%%%%%%%%%%%%%%%%%%%%% Base de Conocimiento %%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%% Punto 1
atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).
atiende(lucas, martes, 10, 20).
atiende(juanC, sabado, 18, 22).
atiende(juanC, domingo, 18, 22).
atiende(juanFdS, jueves, 10, 20).
atiende(juanFdS, viernes, 12, 20).
atiende(leoC, lunes, 14, 18).
atiende(leoC, miercoles, 14, 18).
atiende(martu, miercoles, 23, 24).

atiende(vale, Dia, HorarioEntrada, HorarioSalida):-
    atiende(dodain, Dia, HorarioEntrada, HorarioSalida).

atiende(vale, Dia, HorarioEntrada, HorarioSalida):-
    atiende(juanC, Dia, HorarioEntrada, HorarioSalida).

/*
"nadie hace el mismo horario que leoC" y "maiu está pensando si hace el horario de 0 a 8 los martes y miércoles"

No es necesario ahcer nada por el Principio de Universo Cerrado, en él todo lo que no se encuentra
en la Base de Conocimientos es falso, y todo lo que se encunetra en ella debe ser una verdad absoluta. 
Por esta razón, no es necesario colocar que nadie cumple el mismo horario que leoC, mientras no coloquemos a nadie que lo
haga, ya es suficiente para que eso sea verdad. Por el otro lado, lo que maiu está pensando no está definido
por lo que no es una verdad absoluta y no debe colocarse en la base de conocimientos. 

*/

%%%%%%%%%%%%%%%% Punto 2
quienAtiende(Dia, Horario, Persona):-
    atiende(Persona, Dia, HorarioEntrada, HorarioSalida),
    between(HorarioEntrada, HorarioSalida, Horario). 

%%%%%%%%%%%%%%%% Punto 3
estaSolo(Persona, Dia, Horario):-
    quienAtiende(Dia, Horario, Persona),
    not((quienAtiende(OtraPersona, Dia, HorarioPuntual), Persona \= OtraPersona)).

%%%%%%%%%%%%%%%% Punto 4
personasAtendiendo(Dia, Combinaciones):-
    findall(Persona, atiende(Persona, Dia, _, _), PersonasDisp),
    list_to_set(PersonasDisp, PersonasSinDuplicados),
    combinaciones(PersonasSinDuplicados, Combinaciones).

combinaciones([], []).
combinaciones([Persona | Personas], Combinaciones):-
    combinaciones(Personas, CombSinCabeza),
    findall([Persona | Combinacion], member(Combinacion, CombSinCabeza), CombConCabeza),
    append(CombConCabeza, CombSinCabeza, Combinaciones).

% Punto extra ?

%%%%%%%%%%%%%%%% Punto 5

venta(fecha(lunes, 10, 8), dodain, [golosinas(1200), cigarrillos([jockey]), golosinas(50)]).
venta(fecha(miercoles, 12, 8), dodain, [bebidas(8, alcoholicas), bebidas(1, noAlcoholicas), golosinas(10)]).
venta(fecha(miercoles, 12, 8), martu, [golosinas(1000), cigarrillos([chesterfield, colorado, parisiennes])]).
venta(fecha(martes, 11, 8), lucas, [golosinas(600)]).
venta(fecha(martes, 18, 8), lucas, [bebidas(2, noAlcoholicas), cigarrillos([derby])]).


esSuertuda(Persona):-
    vendedora(Persona),
    forall(venta(_, Persona, [Venta|_]), fueImportante(Venta)).

vendedora(Persona):-
    venta(_, Persona, _).

fueImportante(golosinas(Monto)):-
    Monto > 100.

fueImportante(bebidas(Cant,_)):-
    Cant > 5.

fueImportante(bebidas(_, alcoholicas)).

fueImportante(cigarrillos(Lista)):-
    length(Lista, Long),
    Long > 2. 
    
