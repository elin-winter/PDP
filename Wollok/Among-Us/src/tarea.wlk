import nave.*

class Tarea {
    method mePuedeRealizar(jugador)
    method aplicarEfecto(jugador)

    method jugadorTiene(jugador, elem) =
        jugador.mochila().contains(elem)
}

object arreglarTablero inherits Tarea {
    override method mePuedeRealizar(jugador) = self.jugadorTiene(jugador, "Llave Inglesa")
    override method aplicarEfecto(jugador) {
        jugador.variarSospecha(10)
    }
}

object sacarLaBasura inherits Tarea {
    override method mePuedeRealizar(jugador) = 
        self.jugadorTiene(jugador, "Escoba") and self.jugadorTiene(jugador, "Bolsa de Consorcio")
    override method aplicarEfecto(jugador) {
        jugador.variarSospecha(-4)
    }
}

object ventilarNave inherits Tarea {
    override method mePuedeRealizar(jugador) = true
    override method aplicarEfecto(_) {
        nave.variarOxigeno(5)
    }
}