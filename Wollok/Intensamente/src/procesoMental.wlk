object asentamiento {
    method aplicar(persona) =
        persona.recuerdosDiarios().forEach({x => persona.asentarRecuerdo(x)})
    
}

class AsentamientoSelectivo {
    const palabraClave

    method aplicar(persona) = 
        persona.recuerdos().filter({ r => r.descContiene(palabraClave)}).forEach({r => persona.asentarRecuerdo(r)})
}

object profundizacion {
    method aplicar(persona) {
        const recuerdosLargoPlazo = persona.recuerdos().filter(
            {x => !x.pensamientoCentral() and !persona.niega(x)}
            )
        
        recuerdosLargoPlazo.forEach({x => persona.memoriaLargoPlazo().add()})
    }
}

object controlHormonal {
    method aplicar(persona) {
        if(self.desequilibrioValido(persona)) 
            persona.sufrirDesequilibrio()     
    }

    method desequilibrioValido(persona) =
        persona.pensamientoCentralLargoPlazo() or persona.recuerdosDiariosUniemocionales()
}

object restauracionCognitiva {
    method aplicar(persona) {
        persona.nivelFelicidad(persona.nivelFelicidad() + 100)
    }
}

object liberacionRecuerdos {
    method aplicar(persona) {
        persona.recuerdosDiarios().clear()
    }
}