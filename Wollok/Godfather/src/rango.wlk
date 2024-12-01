import arma.*

class Rango {
    const subordinados
    
    method subordinados() = subordinados

    method nuevoSubordinado(nuevoSub) {
        if(self.condSubordinado(nuevoSub))
            subordinados.add(nuevoSub)
    }

    method condSubordinado(nuevoSub)
    method hacerTrabajo(victima, asesino)

    method despachaElegancia(persona)

}

class Don inherits Rango {

    override method condSubordinado(nuevoSub) =
        nuevoSub.esSoldado() or nuevoSub.esSubjefe()
    
    override method hacerTrabajo(victima, asesino) { 
        subordinados.anyOne().hacerTrabajo(victima)
    }

    method esDon() = true

    override method despachaElegancia(_) = true
}

object donCorleone inherits Don (subordinados = []) {
    override method hacerTrabajo(victima, asesino) {
        2.times(super(victima, asesino))
    }
}


class Subjefe inherits Rango {
    method esSubjefe() = true

    override method condSubordinado(nuevoSub) =
        nuevoSub.esSoldado() 

    override method hacerTrabajo(victima, asesino) = 
        asesino.armas().anyOne().accionar(victima)
    
    override method despachaElegancia(_) = subordinados.any({x => x.tieneArmaSutil()})
}

class Soldado inherits Rango {
    override method condSubordinado(nuevoSub) = false 
    method esSoldado() = true

    override method hacerTrabajo(victima, asesino) = 
        asesino.armas().head().accionar(victima)

    override method despachaElegancia(persona) = persona.tieneArmaSutil()
    
}