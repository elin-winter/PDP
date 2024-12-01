import nave.*


// -------------------------------- Superclase

class Jugador {
  
  // --------- Referencias

  const color
  const tipoVotante
  const tareas

  const mochila = []
  var nivelSospecha = 40
  var property puedeVotar = true

  // --------- Metodos

  // Accesors

  method mochila() = mochila
  
  method nivelSospecha() = nivelSospecha

  method variarSospecha(delta) {
    nivelSospecha += delta
  }

  method usarItem(item) {
    mochila.remove(item)
  }

  method buscarItem(item) {
    mochila.add(item)
  }
  
  // Controles
  
  method esSospechoso() = nivelSospecha > 50
  method tengoTareaPendiente(tarea) = tareas.contains(tarea)
  method completoTodasTareas() = tareas.isEmpty()
  method esImpostor() = false

  // Acciones

  method realizarTarea(tarea) {
    if(tarea.mePuedeRealizar(self) and self.tengoTareaPendiente(tarea)) {
      tarea.aplicarEfecto(self)
      tareas.remove(tarea)
      nave.tareaFueCompletada()
    }
  }

  method llamarReunionEmergencia() {
    nave.generarReunion()
  }

  method votar() = tipoVotante.voto()

}

// -------------------------------- Subclases

class Tripulante inherits Jugador {}

class Impostor inherits Jugador {
  override method esImpostor() = true
  override method realizarTarea(tarea) {}
  override method completoTodasTareas() = true

  method sabotear(sabotaje, victima) {
    sabotaje.aplicarEfecto(victima)
    nivelSospecha += 5
  }
}

// -------------------------------- Tipos de Votantes

object troll {
  method voto() = nave.jugadorEs({x => !x.esSospechoso()})  
}

object detective {
  method voto() = nave.jugadorMasSospechoso()
}

object materialista {
   method voto() = nave.jugadorEs({x => x.mochila().isEmpty()})
}



