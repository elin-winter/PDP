%%%%%%%%%%%%%%%%%%%%%%%%%%%%% La Universidad Obrera %%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% Se Busca

trabaja(juan, electricista, 80).
trabaja(juan, mecanico, 6).
trabaja(marta, maquillista, 30).
trabaja(marta, neurocirujana, 79).
trabaja(mariagracia, manager, 40).
trabaja(sol, ceo, 60).
trabaja(cladio, oftalmologo, 50).
trabaja(claudio, stripper, 20).
trabaja(roberto, pediatra, 40).
trabaja(solana, vendedora, 40).
trabaja(pablo, abogacia, 45).
trabaja(lucia, medicina, 60).
trabaja(juan, arquitectura, 55).
trabaja(natalia, filosofia, 35).
trabaja(gabriel, ingenieriaIndustrial, 50).
trabaja(maria, odontologa, 45).
trabaja(david, sociologo, 40).
trabaja(fabiola, diseniadoraGrafica, 38).
trabaja(laura, cientificaPolitica, 42).
trabaja(martin, economista, 50).
trabaja(mariana, veterinaria, 48).
trabaja(federico, ingElectrica, 52).
trabaja(nerea, historiadora, 40).
trabaja(claudia, publicista, 37).
trabaja(patricia, relacionesInternacionales, 46).
trabaja(alicia, urbanista, 47).
trabaja(pablo, ingenieriaMecanica, 55).
trabaja(juan, desarrollador, 60).
trabaja(lucia, cirujano, 55).
trabaja(natalia, profesor, 40).
trabaja(gabriel, consultor, 50).
trabaja(maria, higienistaDental, 42).
trabaja(david, terapeuta, 44).
trabaja(fabiola, ilustradora, 37).
trabaja(laura, investigador, 43).
trabaja(martin, contador, 48).
trabaja(federico, tecnicoElectrico, 50).
trabaja(nerea, archivista, 35).
trabaja(claudia, especialistaMarketing, 39).
trabaja(patricia, coordinadoraEventos, 45).

estudia(juan, ingSistemas, utn).
estudia(juan, ingQuimica, utn).
estudia(marta, podologia, uba).
estudia(sol, podologia, uba).
estudia(pili, marketing, uade).
estudia(roberto, ingSistemas, utn).
estudia(roberto, ingInformatica, uba).
estudia(pablo, abogacia, uba).
estudia(lucia, medicina, uba).
estudia(juan, arquitectura, uba).
estudia(natalia, filosofia, uca).
estudia(gabriel, ingenieriaIndustrial, uade).
estudia(maria, odontologia, uba).
estudia(david, sociologia, utn).
estudia(fabiola, disenioGrafico, uces).
estudia(laura, cienciasPoliticas, uba).
estudia(martin, economicas, uca).
estudia(mariana, veterinaria, unlp).
estudia(federico, ingElectrica, utn).
estudia(nerea, historia, uba).
estudia(claudia, publicidad, uade).
estudia(patricia, relacionesInternacionales, uca).
estudia(luis, biologia, unlp).
estudia(alicia, arquitectura, uces).
estudia(pablo, ingenieriaMecanica, utn).



% Punto 1

uniObrera(Universidad):-
    uni(Universidad),
    forall(estudia(Alumno, _, Universidad), trabaja(Alumno, _, _)).

uni(Universidad):-
    estudia(_, _, Universidad).

% Punto 2

carreraExigente(Carrera, Universidad):-
    estudia(Alguien, Carrera, Universidad),
    not(trabaja(Alguien, _, _)),
    not((estudia(Alguien, OtraCarrera, _), OtraCarrera \= Carrera)).

% Punto 3

uniConMasTrabajadores(Universidad):-
    uni(Universidad),
    cantTrabajadores(Universidad, Max),
    forall(uni(OtraUni), (cantTrabajadores(OtraUni, Cant), Cant =< Max)).

cantTrabajadores(Uni, Cant):-
    findall(Trabajador, estudiaYTrabaja(Trabajador, Uni), Trabajadores),
    length(Trabajadores, Cant).

estudiaYTrabaja(Sufrido, Uni):-
    estudia(Sufrido, _, Uni), 
    trabaja(Sufrido, _, _).

% Punto 4

trabajanNoVinculado(Persona):-
    estudia(Persona, Carrera, _),
    trabaja(Persona, Area, _),
    Carrera \= Area.

% Punto 5

carreraDemandada(Carrera):-
    estudia(_, Carrera, _),
    forall(
        (estudia(Estudiante, Carrera, _), 
        trabaja(Estudiante, Area, _)), 
        Carrera = Area).

%%%%%%%%%%%%%%%%%% Ambiente Laboral

% Hechos de empleo privado
empleoPrivado(google, tecnologia).
empleoPrivado(bancoNacion, finanzas).
empleoPrivado(apple, tecnologia).
empleoPrivado(petrobras, energia).
empleoPrivado(mercadoLibre, comercio).

% Hechos de empleo público
empleoPublico(ministerioDeSalud, hospital, salud).
empleoPublico(conicet, investigacion, ciencia).
empleoPublico(afip, recaudacion, economia).
empleoPublico(judicial, tribunal, justicia).

% Hechos de planes sociales
planSocial(progresar).
planSocial(asignacionUniversal).
planSocial(pensionNoContributiva).

% Hechos de organizaciones
organizacion(cruzRoja, salud).
organizacion(onu, internacional).
organizacion(verdePorElPlaneta, medioambiente).
organizacion(unicef, infancia).
organizacion(progresar, educacion).
organizacion(asignacionUniversal, administracion).
organizacion(pensionNoContributiva, verduleria).

% Hechos de habilitación profesional
habilitacionProfesional(ingenieria, [ingenieroIndustrial, ingenieroMecanico, ingenieroElectrico]).
habilitacionProfesional(filosofia, [filosofo]).
habilitacionProfesional(medicina, [medico, cirujano]).
habilitacionProfesional(disenioGrafico, [diseniadorGrafico, ilustrador]).
habilitacionProfesional(publicidad, [publicista]).
habilitacionProfesional(arquitectura, [arquitecto, urbanista]).
habilitacionProfesional(abogacia, [abogado]).
habilitacionProfesional(veterinaria, [veterinario]).
habilitacionProfesional(sociologia, [sociologo]).
habilitacionProfesional(historia, [historiador]).
habilitacionProfesional(relacionesInternacionales, [relacionistaInternacional, coordinadorEventos]).

%%%%%%%%%%%%%%%%%% Trabajo Creativo

% Hechos de emprendedores y sus proyectos
emprendedor(juan, startupTecnologia).
emprendedor(marta, consultoriaSalud).
emprendedor(federico, innovacionEnergetica).

% Hechos de rubros de proyectos
rubroDeProyecto(startupTecnologia, tecnologia).
rubroDeProyecto(consultoriaSalud, salud).
rubroDeProyecto(innovacionEnergetica, energia).

% Regla para deducir el rubro de un emprendedor
trabaja(Emprendedor, Rubro, 60) :-
    emprendedor(Emprendedor, Proyecto),
    rubroDeProyecto(Proyecto, Rubro),
    empleoPrivado(_, Rubro).

trabaja(Emprendedor, Rubro, 80) :-
    emprendedor(Emprendedor, Proyecto),
    rubroDeProyecto(Proyecto, Rubro),
    empleoPublico(_, _, Rubro).
