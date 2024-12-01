import procesoMental.*
import recuerdo.*

// ------------------------- Riley

object riley {

    // -------------- Referencias

    var nivelFelicidad = 1000
    var emocionDominante = null
    var edad = 11
    var pensamientoActual = null

    const memoriaLargoPlazo = []
    const recuerdos = []
    const recuerdosDiarios = []

    const procesosMentales = [
        asentamiento, 
        new AsentamientoSelectivo(palabraClave = "comer"),
        profundizacion, 
        controlHormonal,
        restauracionCognitiva, 
        liberacionRecuerdos]

    // -------------- Metodos

    // Accesors

    method recuerdos() = recuerdos
    method recuerdosDiarios() = recuerdosDiarios
    method memoriaLargoPlazo() = memoriaLargoPlazo

    method nivelFelicidad(nuevoNivel) {
        if(nuevoNivel < 1)
            throw new DomainException (message = "Nivel no puede ser menor a 1")
        
        nivelFelicidad = nuevoNivel.max(1).min(1000)
    }

    method emocionDominante(nuevaEmocion) {
        emocionDominante = nuevaEmocion
    }

    method cumplirAnios() {
        edad += 1
    }

    // Consulta

    method recuerdosRecientes() = recuerdos.drop(recuerdos.size() - 5)

    method pensamientosCentrales() = recuerdos.filter({r => r.pensamientoCentral()}).asSet()

    method pensamientosCentralesDificilesExplicar() =
        self.pensamientosCentrales().filter({p => p.difilExplicar()})

    method dormir() = procesosMentales.forEach({p => p.aplicar(self)})

    method pensamientoCentralLargoPlazo() =
        memoriaLargoPlazo.any({r => r.pensamientoCentral()})
    
    method recuerdosDiariosUniemocionales() {
        
        const unaEmocion = recuerdosDiarios.anyOne().emocionDominante()

        return recuerdosDiarios.all({r => r.emocionDominante() == unaEmocion})
    }

    method niega(recuerdo) = emocionDominante.niega(recuerdo)

    method condicionRememorar(recuerdo) {
        const anioActual = new Date().year()

        return anioActual - recuerdo.fecha().year() > edad / 2
    }

    method cantRepeticiones(recuerdo) =
        memoriaLargoPlazo.occurrencesOf(recuerdo)

    method teniendoDejaVu() =
        memoriaLargoPlazo.any({ r => r.desc() == pensamientoActual.desc()})

    // Efecto
    
    method vivirEvento(descEvento) = new Recuerdo(
            desc = descEvento,
            fecha = new Date(), 
            emocionDominante = emocionDominante
        )

    method asentarRecuerdo(recuerdo) {
        emocionDominante.asentar(recuerdo, self)
        recuerdosDiarios.add(recuerdo)
    }

    method sufrirDesequilibrio() {
        nivelFelicidad *= 0.85
        recuerdos.drop(3)
    }

    method rememorar() {
        
        pensamientoActual = memoriaLargoPlazo.filter(
            {r => self.condicionRememorar(r)}).anyOne()
    }
        
}