import nave.*

class Sabotaje {
    method aplicarEfecto(jugador)
}

object reducirOxigeno inherits Sabotaje {
    override method aplicarEfecto(_) {
        if(!nave.algunTuboOxigeno())
            nave.variarOxigeno(-10)
    }
}

object impugnarJugador inherits Sabotaje {
    override method aplicarEfecto(jugador) {
        jugador.puedeVotar(false)
    } 
}