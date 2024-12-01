import plataforma.*
import paises.*
import juegos.*

class Critica {
    var texto
    var esPositiva

    method esPositiva() = esPositiva
}

object positiva {
    method textoUsuario() = "SI"
    method esPositiva() = true
}

object negativa {
    method textoUsuario() = "NO"
    method esPositiva() = false
}

class Critico {
    method daCriticaPositiva(juego)
    method textoCritica()
    method criticar(juego) {
        
        const critica = 
            new Critica(
                texto = self.textoCritica(), 
                esPositiva = self.daCriticaPositiva(juego)
                )
        
        juego.recibirCritica(critica)
    }

    method recibeNuevo(coleccion, nuevoElem) {
        coleccion.add(nuevoElem)
    }

    method pierdeElem(coleccion, nuevoElem) {
        coleccion.remove(nuevoElem)
    }
}
class Usuario inherits Critico {
    const opinion
    override method textoCritica() = opinion.textoUsuario()
    override method daCriticaPositiva(_) = opinion.esPositiva()
}

class CriticosPagos inherits Critico {
    const juegosPagados

    const palabrasRandom = ["buenisimo", "aburrido", "entretenido", "terrorifico"]

    override method daCriticaPositiva(juego) = juegosPagados.contains(juego)

    override method textoCritica() = palabrasRandom.anyOne() 

    method recibirPagoJuego(juego) {
        self.recibeNuevo(juegosPagados, juego)
    }

    method dejarDeRecibirPago(juego) {
        self.pierdeElem(juegosPagados, juego)
    }
}

class Revista inherits Critico {

    const criticosEmpleados

    override method daCriticaPositiva(juego) = 
        self.empleadosCriticaPositiva(juego) > criticosEmpleados.size()/2
    
    override method textoCritica() = 
        criticosEmpleados.flatMap({x => x.textoCritica()})
    
    method empleadosCriticaPositiva(juego) =
        criticosEmpleados.filter({x => x.daCriticaPositiva(juego)}).size()
    
    method nuevoEmpleado(critico) {
        self.recibeNuevo(criticosEmpleados, critico)
    }

    method pierdeEmpleado(critico) {
        self.pierdeElem(criticosEmpleados, critico)
    }

}
