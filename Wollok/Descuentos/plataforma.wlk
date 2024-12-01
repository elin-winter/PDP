import juegos.*
import criticas.*
import paises.*

object estim {

  const juegos = []

  method juegos() = juegos

  method agregarJuego(juego) {
    juegos.add(juego)
  }
  
  method descuentoAJuegosBaratos(porcentaje) {
    const juegosADescuentar = juegos.filter({x => x.precioActual() > 0.75 * self.precioMasCaro()})
    juegosADescuentar.forEach({x => x.descuentoDirecto(porcentaje)})
  }

  method precioMasCaro() {
    return juegos.max({x => x.precioActual()}).precioActual()
  }

  method algunoGalardonado() = juegos.any({ x => x.noRecibioCriticasNegativas()})
}