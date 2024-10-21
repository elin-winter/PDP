%%%%%%%%%%%%%%%%%%%%%%%% Mascotas Chapitas %%%%%%%%%%%%%%%%%%%%%%



% perro(tamaño)
% gato(sexo, cantidad de personas que lo acariciaron)
% tortuga(carácter)


mascota(pepa, perro(mediano)).
mascota(frida, perro(grande)).
mascota(piru, gato(macho,15)).
mascota(kali, gato(macho,3)).
mascota(olivia, gato(hembra,16)).
mascota(mambo, gato(macho,2)).
mascota(abril, gato(hembra,4)).
mascota(buenaventura, tortuga(agresiva)).
mascota(severino, tortuga(agresiva)).
mascota(simon, tortuga(tranquila)).
mascota(quinchin, gato(macho,0)).
% mascota(carlo, gato(macho,20)).

%%%%%%%%%%%%%%%%%%%%%%% Punto 1

adopcion(martin, pepa, 2014).
adopcion(martin, frida, 2015).
adopcion(martin, kali, 2016).
adopcion(martin, olivia, 2014).
adopcion(constanza, mambo, 2014).
adopcion(hector, abril, 2014).
adopcion(hector, mambo, 2014).
adopcion(hector, buenaventura, 1971).
adopcion(hector, severino, 2007).
adopcion(hector, simon, 2016).
% adopcion(miranda, carlo, 2016).

compra(hector, abril, 2006).
compra(martin, piru, 2010).

/*
compra(constanza, abril, 2006).
compra(constanza, piru, 2010).
compra(constanza, abril, 2006).
compra(constanza, piru, 2010).

*/

regalo(constanza, abril, 2006).
regalo(silvio, quinchin, 1990).

/*

?- adopcion(constanza, mambo, 2008).
false.

*/

%%%%%%%%%%%%%%%%%%%%%%% Punto 2

comprometidos(P1, P2):-
    adopcion(P1, Mascota, Anio),
    adopcion(P2, Mascota, Anio),
    P1 \= P2.

%%%%%%%%%%%%%%%%%%%%%%% Punto 3

locoDeLosGatos(Persona):-
    masDeUnGato(Persona),
    forall(duenio(Persona, Mascota, _), esGato(Mascota)).

masDeUnGato(Persona):-
    duenio(Persona, M1, _),
    esGato(M1),
    duenio(Persona, M2, _),
    esGato(M2),
    M1 \= M2.

esGato(Mascota):-
    mascota(Mascota, gato(_, _)).

duenio(Persona, Mascota, Anio):-
    adopcion(Persona, Mascota, Anio).
duenio(Persona, Mascota, Anio):-
    compra(Persona, Mascota, Anio).
duenio(Persona, Mascota, Anio):-
    regalo(Persona, Mascota, Anio).

%%%%%%%%%%%%%%%%%%%%%%% Punto 4

puedeDormir(Persona):-
    duenio(Persona, _, _),
    not((duenio(Persona, Mascota, _), esChapita(Mascota))).

esChapita(NombreMascota):-
    mascota(NombreMascota, InfoMascota),
    calificaChapita(InfoMascota).

calificaChapita(perro(chico)).
calificaChapita(tortuga(_)).
calificaChapita(gato(macho, Cant)):-
    Cant < 10.

%%%%%%%%%%%%%%%%%%%%%%% Punto 5

% Parte A
crisisNerviosa(Persona, Anio) :-
    anioAnterior(Anio, AnioAnterior),
    duenio(Persona, M1, AnioAnterior),
    esChapita(M1),
    duenio(Persona, M2, AnioPrevio),
    esChapita(M2),
    AnioPrevio < AnioAnterior.

anioAnterior(Anio, AnioAnterior):-
    AnioAnterior is Anio - 1.

% Parte B

/*
La funcion es parcialmente inversible, aunque se pueden realizar
consultas existenciales con la persona, es imposible realizarlas con el año.

Es inversible para la persona porque encontramos un hecho generador de personas,
asi se evalua la condición en ellas. Este hecho es duenio(Persona, M1, AnioAnterior), que unifica 
a Persona con todas aquellas que son dueños de mascotas (lo que requerimos).

No podemos hacer lo mismo con los años, ya que no hay forma de instanciarlo lo 
suficiente, a menos que usemos interger(num), o algo parecido.

*/

%%%%%%%%%%%%%%%%%%%%%%% Punto 6

mascotaAlfa(Persona, Alfa):-
    duenio(Persona, Alfa, _),
    forall((duenio(Persona, Beta, _), Alfa \= Beta), domina(Alfa, Beta)).

domina(M1, M2):-
    mascota(M1, Info1),
    mascota(M2, Info2),
    dominaA(Info1, Info2).

dominaA(gato(_, _), perro(_)).
dominaA(perro(grande), perro(chico)).
dominaA(G1, G2):-
    calificaChapita(G1),
    not(calificaChapita(G2)).
dominaA(tortuga(agresiva), _).

%%%%%%%%%%%%%%%%%%%%%%% Punto 7

materialista(Persona):-
    not(duenio(Persona, _, _)).

materialista(Persona):-
    duenio(Persona, _, _),
    cantCompradas(Persona, CantComprada),
    cantAdoptada(Persona, CantAdoptada),
    CantComprada > CantAdoptada.

cantCompradas(Persona, Cant):-
    findall(MC, compra(Persona, MC, _), MCS),
    length(MCS, Cant).

cantAdoptada(Persona, Cant):-
    findall(MA, adopcion(Persona, MA, _), MAS),
    length(MAS, Cant).
