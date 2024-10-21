%%%%%%%%%%%%%%%%%%%%%%%% 31 Minutos: Prolog Chileno %%%%%%%%%%%%%%%%%%

% Cancion, Compositores,  Reproducciones
cancion(bailanSinCesar, [pabloIlabaca, rodrigoSalinas], 10600177).
cancion(yoOpino, [alvaroDiaz, carlosEspinoza, rodrigoSalinas], 5209110).
cancion(equilibrioEspiritual, [danielCastro, alvaroDiaz, pabloIlabaca, pedroPeirano, rodrigoSalinas], 12052254).
cancion(tangananicaTanganana, [danielCastro, pabloIlabaca, pedroPeirano], 5516191).
cancion(dienteBlanco, [danielCastro, pabloIlabaca, pedroPeirano], 5872927).
cancion(lala, [pabloIlabaca, pedroPeirano], 5100530).
cancion(meCortaronMalElPelo, [danielCastro, alvaroDiaz, pabloIlabaca, rodrigoSalinas], 3428854).

% Mes, Puesto, Cancion
rankingTop3(febrero, 1, lala).
rankingTop3(febrero, 2, tangananicaTanganana).
rankingTop3(febrero, 3, meCortaronMalElPelo).
rankingTop3(marzo, 1, meCortaronMalElPelo).
rankingTop3(marzo, 2, tangananicaTanganana).
rankingTop3(marzo, 3, lala).
rankingTop3(abril, 1, tangananicaTanganana).
rankingTop3(abril, 2, dienteBlanco).
rankingTop3(abril, 3, equilibrioEspiritual).
rankingTop3(mayo, 1, meCortaronMalElPelo).
rankingTop3(mayo, 2, dienteBlanco).
rankingTop3(mayo, 3, equilibrioEspiritual).
rankingTop3(junio, 1, dienteBlanco).
rankingTop3(junio, 2, tangananicaTanganana).
rankingTop3(junio, 3, lala).

%%%%%%%%%%%%%%%%%%%%%%%%%% Canciones

% Punto 1
esHit(Cancion):-
    esCancion(Cancion),
    forall(rankingTop3(Mes, _, _), rankingTop3(Mes, _, Cancion)).

esCancion(Cancion) :-
    cancion(Cancion, _, _).

% Punto 2

noReconocidaPorCriticos(Cancion):-
    cancion(Cancion, _, Repros),
    Repros > 7000000,
    not(rankingTop3(_, _, Cancion)).

% Punto 3

sonColaboradores(Compositor1, Compositor2):-
    cancion(_, Compositores, _),
    member(Compositor1, Compositores),
    member(Compositor2, Compositores),
    Compositor1 \= Compositor2.

esCompositor(Compositor):-
    cancion(_, Compositores, _),
    member(Compositor, Compositores).

%%%%%%%%%%%%%%%%%%%%%%%%%% Trabajos

% Punto 4

% conductor(aniosExperiencia).
% periodista(aniosExperiencia, titulo).
% reportero(aniosExperiencia, cantNotas).
trabajo(tulio, conductor(5)).
trabajo(juanin, conductor(0)).
trabajo(bodoque, periodista(2, licenciatura)).
trabajo(bodoque, reportero(5, 300)).
trabajo(marioHugo, periodista(10, posgrado)).

% Punto 5

sueldoTotal(Persona, Sueldo):-
    trabajo(Persona, _),
    findall(Salario, sueldoSegunTrabajo(Persona, Salario), Sueldos),
    sumlist(Sueldos, Sueldo).

sueldoSegunTrabajo(Persona,Sueldo):-
    trabajo(Persona, Trabajo),
    cuantoCobra(Trabajo, Sueldo).

cuantoCobra(conductor(Anios), Sueldo):-
    Sueldo is Anios * 10000.

cuantoCobra(reportero(Anios, CantNotas), Sueldo):-
    Sueldo is Anios * 10000 + 100 * CantNotas.

cuantoCobra(periodista(Anios, Titulo), Sueldo):-
    aumentoSegunTitulo(Titulo, Aumento),
    Sueldo is Anios * 5000 * (1 + Aumento/100).

aumentoSegunTitulo(posgrado,35).
aumentoSegunTitulo(licenciatura,20).

% Punto 6

% camarografo(aniosExperiencia, camarasQueManeja, con o sin estudios formales)
trabajo(marioHugo, camarografo(10, [sony360, kodak4Mil, blueVision], sinEstudios)).

cuantoCobra(camarografo(Anios, CamarasConoce, sinEstudios), Sueldo):-
    length(CamarasConoce, CantCamaras),
    Sueldo is Anios * 200 * CantCamaras * 2.

cuantoCobra(camarografo(Anios, CamarasConoce, conEstudios), Sueldo):-
    length(CamarasConoce, CantCamaras),
    Sueldo is Anios * 200 * CantCamaras * 4.

% Polimorfismo y pattern matching


    
