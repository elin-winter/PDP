import juegos.*
import plataforma.*
import criticas.*

class Pais {
    var factorConversion
    const caractsProhibidasMenores

    method conversionDolaresLocal(precioDolares) {
        return precioDolares * factorConversion
    }

    method juegoAptoMenores(juego) = 
        caractsProhibidasMenores.asSet(). intersection(juego.caracteristicas().asSet()).isEmpty()
    
    method promedioPrecioMonedaLocal(plat) =
        self.conversionDolaresLocal(self.promedioPrecioJuegos(plat))

    method promedioPrecioJuegos(plat) =
        self.sumaPrecioJuegos(self.juegosAptosMenoresPlat(plat)) / plat.juegos().size()
    
    method sumaPrecioJuegos(lista) = 
        lista.map({x => x.precioActual()}).sum()
    
    method juegosAptosMenoresPlat(plat) =
        plat.juegos().filter({x => self.juegoAptoMenores(x)})
}