import haciendoNumeros.*
class Analista {
    const nombre

    var cantArticulos = 0

    method nombre() = nombre
    method cantArticulos() = cantArticulos

    method obtenerCifra(pais) = self.estrategia(pais).valor(pais)

    method escribirArt(pais) {

        cantArticulos +=1
        
        return new Articulo(
            titulo = self.titulo(pais),
            cifraDestacada = self.obtenerCifra(pais), 
            analista = self 
        )
    
    }
    
    method titulo(pais)
    method estrategia(_)
}

class Clasico inherits Analista {
    override method estrategia(_) = pbiXCapita
    override method titulo(pais) = "La situacion en" + pais.nombre()
}

class Rebelde inherits Analista {
    var property estrategia

    override method obtenerCifra(_) = 
        estrategia.valor(self.paisParaEscribir())
    
    override method titulo(_) = "Mejor Pais del Mundo"

    method paisParaEscribir() = diario.mejorPaisDelMundo(estrategia)
}

class Panqueque inherits Analista {
    const estrategiaPositiva
    const estrategiaNegativa
    const paisesSimpaticos

    override method estrategia(pais) = 
        if(self.eleccionEstrategia(pais)) estrategiaPositiva
        else estrategiaNegativa
    
    method eleccionEstrategia(pais) = paisesSimpaticos.contains(pais)
    
    override method titulo(_) = "La columna economica de" + self.nombre()
}

object juanciPayo inherits Panqueque(
    estrategiaPositiva = gini, 
    estrategiaNegativa = ingresosAltos, 
    paisesSimpaticos = [], 
    nombre = "Juanci Payo") {

    override method eleccionEstrategia(pais) = pais != argentina
    override method obtenerCifra(pais) = super(pais) * 1.5

}

const estebanQuito = new Panqueque(
    estrategiaPositiva = accesoUniversidad,
    estrategiaNegativa = gini,
    paisesSimpaticos = [colombia, ecuador, bolivia, argentina], 
    nombre = "Esteban Quito"
)

const soniaDora = new Panqueque(
    estrategiaPositiva = ingresosAltos,
    estrategiaNegativa = nombrista,
    paisesSimpaticos = [suecia, noruega], 
    nombre = "Esteban Quito"
)

class Salieris inherits Analista {
    var analistaCopiado

    override method escribirArt(pais) = analistaCopiado.escribirArt(pais).analista(self)

    method analistaCopiado(nuevo) {
        analistaCopiado = nuevo
    }
}

class RebeldeMalvado inherits Rebelde {
    
    override method titulo(_) = "Peor Pais del Mundo"
    override method paisParaEscribir() = diario.peorPaisDelMundo(estrategia)

}








class Articulo {
    const titulo
    const cifraDestacada
    var property analista
}

