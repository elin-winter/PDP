// ------------------------- Superclase

class Emocion {
    method niega(_) = false
    method asentar(_, __) {}
}

// ------------------------- Emociones Particulares

object alegria inherits Emocion {
    override method niega(recuerdo) = 
        recuerdo.emocionDominante() != self
    
    method esAlegre() = true

    override method asentar(recuerdo, persona) {
        if(persona.nivelFelicidad() > 500)
            recuerdo.pensamientoCentral(true)
    }
}
object tristeza inherits Emocion {
    override method niega(recuerdo) =
        recuerdo.emocionDominante() == alegria
    
    override method asentar(recuerdo, _) =
            recuerdo.pensamientoCentral(true)
    
}
const disgusto = new Emocion()
const furia = new Emocion()
const temor = new Emocion()

// ------------------------- Emociones Compuestas

class EmocionCompuesta inherits Emocion {
    const emociones

    override method niega(recuerdo) = emociones.all({e => e.niega(recuerdo)})
    
    method esAlegre() = emociones.any({e => e.esAlegre()})
    
    override method asentar(recuerdo, persona) = 
        emociones.forEach({e => e.asentar(recuerdo, persona)})
} 