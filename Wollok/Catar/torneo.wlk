class Torneo {
    const catadores
    const participantes

    method cocineroParticipa(cocinero) {
        participantes.add(cocinero)
    }

    method obtenerPuntaje(participante) {
        const plato = participante.cocinar()
        return catadores.map({x => x.catar(plato)}).sum()
    }

    method cocineroGanador() {
        if (participantes.isEmpty()) 
			throw new DomainException(message = "No se puede definir el ganador de un torneo sin participantes")

        return participantes.max({x => self.obtenerPuntaje(x)})
    }
}