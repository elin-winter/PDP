// ------------------------- Diario

object diario {
    const paisesMundo = []
    const analistas = []
    var historial = []

    method nuevoAnalista(analista) {
        analistas.add(analista)
    }

    method mejorPaisDelMundo(estrategia) = 
        paisesMundo.max({x => estrategia.valor(x)})
    
    method peorPaisDelMundo(estrategia) = 
        paisesMundo.min({x => estrategia.valor(x)})
    
    method armarNuevaEdicion() {
        const paisElegido = paisesMundo.anyOne()
        const analistasElgidos = analistas.filter({x => self.puedenEscribir(paisElegido, x)})

        historial += analistasElgidos.map({x => x.escribirArt(paisElegido)})

    }

    method puedenEscribir(pais, analista) = 
        analista.cantArticulos() < 3 and !analista.nombre().contains(pais.nombre())
}

// ------------------------- Estrategias

object pbiXCapita {
    method valor(pais) = pais.pbi() / pais.cantHabitantes()
}

object gini {
    method valor(pais) = pais.ingresosMedios().last() / pais.ingresosMedios().head()
}

object ingresosAltos {
    method valor(pais) = pais.ingresosMedios().last()
}
object accesoUniversidad {
    method valor(pais) = pais.porcentajePoblacionUniversidad()
}
object nombrista {
    method valor(pais) = pais.nombre().size() * 10
}

object cantHabitantesUniversidad {
    method valor(pais) = pais.porcentajePoblacionUniversidad() * pais.cantHabitantes() 
}

// ------------------------- Pais

class Pais {
    const property pbi
    const property cantHabitantes
    const property porcentajePoblacionUniversidad
    const property ingresosMedios
    const property nombre
}

const colombia = new Pais(
    pbi = 15,
    cantHabitantes = 3000,
    porcentajePoblacionUniversidad = 15,
    ingresosMedios = [2873, 9282, 19394, 37485, 240593, 837463, 9384750, 10394857, 203947562],
    nombre = "Colombia"
)

const bolivia = new Pais(
    pbi = 15,
    cantHabitantes = 3000,
    porcentajePoblacionUniversidad = 15,
    ingresosMedios = [2873, 9282, 19394, 37485, 240593, 837463, 9384750, 10394857, 203947562],
    nombre = "Bolivia"
)

const argentina = new Pais(
    pbi = 15,
    cantHabitantes = 3000,
    porcentajePoblacionUniversidad = 15,
    ingresosMedios = [2873, 9282, 19394, 37485, 240593, 837463, 9384750, 10394857, 203947562],
    nombre = "Argentina"
)

const ecuador = new Pais(
    pbi = 15,
    cantHabitantes = 3000,
    porcentajePoblacionUniversidad = 15,
    ingresosMedios = [2873, 9282, 19394, 37485, 240593, 837463, 9384750, 10394857, 203947562],
    nombre = "Ecuador"
)

const suecia = new Pais(
    pbi = 19383,
    cantHabitantes = 9000,
    porcentajePoblacionUniversidad = 90,
    ingresosMedios = [10001, 10010, 10100, 11000, 11010, 110100, 111000, 1110001, 1110010, 1110100],
    nombre = "Suecia"
)

const noruega = new Pais(
    pbi = 15292383,
    cantHabitantes = 30,
    porcentajePoblacionUniversidad = 90,
    ingresosMedios = [10001, 10010, 10100, 11000, 11010, 110100, 111000, 1110001, 1110010, 1110100],
    nombre = "Noruega"
)

