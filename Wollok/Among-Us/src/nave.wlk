object nave {

  // --------- Referencias

  var jugadores = []
  var jugadoresActivos = []

  var cantImpostores = 0 
  var cantTripulantes = 0 
  var nivelOxigeno = 0

  // --------- Metodos

  // Accesors

  method variarOxigeno(delta) {
    nivelOxigeno += delta

    if(nivelOxigeno <= 0) self.ganaTripu(false)
  }

  method actualizarCants(jugador) {
    if(jugador.esImpostor()) cantImpostores =-1
    else cantTripulantes =- 1
  }

  // Controles

  method todaTareaCompletada() = jugadores.all({x => x.completoTodasTareas()})
  method algunTuboOxigeno() = jugadores.any({x => x.mochila().contains("Tubo de Oxigeno")})
  
  method chequearGanador() {
    if(cantImpostores == 0) self.ganaTripu(true)
    if(cantTripulantes == 0) self.ganaTripu(false)
  }

  

  // Acciones

  method tripulacionInicial(tripulacion) {
    jugadores = tripulacion
    jugadoresActivos = tripulacion
  }

  method tareaFueCompletada() {
    if(self.todaTareaCompletada()) self.ganaTripu(true)
  }

  method generarReunion() {
    const votos = jugadoresActivos.filter({x => x.puedeVotar()}).map({x => x.votar()})
    const jugadortMasVotado = votos.max({x => votos.occurrencesOf(x)})

    if(jugadortMasVotado != blanco) {
      jugadoresActivos.remove(jugadortMasVotado)
      self.actualizarCants(jugadortMasVotado)
      self.chequearGanador()
    }  
  }

  method ganaTripu(valor) {
    var mensaje
    if(valor) mensaje = "Ganaron los tripulantes"
    else mensaje = "Ganaron los impostores"
    
    throw new DomainException(message = mensaje) 
  }

  method jugadorEs(bloqueCod) {
    const lista = jugadoresActivos.filter(bloqueCod) 

    if(lista.isEmpty()) return blanco
    else lista.anyOne()
  }

  method jugadorMasSospechoso() = jugadoresActivos.max({x => x.nivelSospecha()})
}

object blanco {}
