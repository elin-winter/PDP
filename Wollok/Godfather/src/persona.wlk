import arma.*

class Persona {
  var property rango
  const armas
  var lealtadAFamilia

  var estaVivo = true
  var property herida = false

  method lealtadAFamilia() = lealtadAFamilia
  
  method aumentarLealtad(delta) {
    lealtadAFamilia *= delta
  }

  method morir() {
    estaVivo = false
  }

  method agregarArma(nuevaArma) {
        armas.add(nuevaArma)
    }

  method armas() = armas

  method trabajar(victima) = rango.hacerTrabajo(victima)

  method durmiendoConLosPeces() = !estaVivo

  method despachaElegancia() = rango.despachaElegancia(self)

  method iniciar() {
    self.agregarArma(new Escopeta())
  }

  method tieneArmaSutil() = armas.any({a => a.sutil()})

  method atacarFamilia(familia) {
    const victima = familia.peligroso()
    if(victima != null)
      self.trabajar(victima)
    else
      throw new DomainException (message = "Ya no queda miembros por atacar :)")
  }
  
}

