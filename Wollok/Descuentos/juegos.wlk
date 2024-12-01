import plataforma.*
import paises.*
import criticas.*

class Juego {
  const precioDolares
  var precioActual = precioDolares
  const caracteristicas
  const criticas = []

  method caracteristicas() = caracteristicas

  method recibirCritica(critica) {
    criticas.add(critica)
  }

  method pasaUmbralPositivo(cant) =
    criticas.filter({x => x.esPositiva()}).size() > cant
  
  method noRecibioCriticasNegativas() = criticas.all({x => x.esPositiva()})

  method tieneCriticoLiterario() = criticas.any({x => x.textoCritica().size() > 100})

  method descuentoDirecto(porcentaje) {
    const factorDescuento = porcentaje.min(0).max(100) / 100
    precioActual = precioDolares * factorDescuento
  }

  method descuentoFijo(cant) {
    precioActual = (precioDolares - cant).max(precioDolares/2)
  }

  method gratis() {
    precioActual = 0
  }

  method precioActual() = precioActual

}

class JuegoInfantil inherits Juego {
  const edadMinimaRecomendada

  override method descuentoDirecto(porcentaje) {
    super(porcentaje)
    super(edadMinimaRecomendada)
  }
}

