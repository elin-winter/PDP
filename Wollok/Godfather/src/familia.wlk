import arma.*
import rango.*

class Familia {

  // ----------------- Referencias

  const miembros

  // ----------------- Metodos

  // Consulta

    method nuevoMiembroDon(persona) =  persona.esDon() and !self.yaHayDon()
    
    method yaHayDon() = miembros.any({m => m.esDon() and m.estaVivo()})
    
    method peligroso() = 
        if(self.miembrosVivos().isEmpty())
            null
        else 
          self.miembrosVivos().max({ m => m.armas().size()}) 
    
    method miembrosVivos() = 
        miembros.filter({m => m.estaVivo()})
    
    method condAvanzarSoldado(miembro) =
        miembro.rango().esSoldado() and miembro.armas().size() > 5

  // Efecto

  method nuevoMiembro(persona) {
    if(self.nuevoMiembroDon(persona) or !persona.esDon()) 
        miembros.add(persona)
  }

  method distribuirArmas() {
    miembros.forEach({m => m.agregarArma(new Revolver(cantBalas = 6))})
  }

  method ataqueSorpresa(familia) {
    miembros.forEach({m => m.atacarFamilia(familia)})
  }

  method luto() {
    const don = self.muereDon()
    self.soldadosAvanzan()

    const nuevoDon = self.nuevoDon(don)
    
    if(nuevoDon == null) 
        throw new DomainException (message = "No hay candidato para nuevo Don")
    else 
        nuevoDon.rango(new Don(subordinados = nuevoDon.subordinados()))
    
    miembros.forEach({m => m.aumentarLealtad(1.1)})

  }

  method muereDon() {
    const don = miembros.find({m => m.esDon() and m.estaVivo()})
    don.morir()

    return don
  }

  method soldadosAvanzan() {
    const soldadosParaAvanzar = miembros.filter({m => self.condAvanzarSoldado(m)})
    soldadosParaAvanzar.forEach({ s => s.rango(new Subjefe(subordinados = []))})
  }

  method nuevoDon(don) {
    const nuevoDon = don.rango().subordinados().max({s => s.lealtadAFamilia()})

    if(nuevoDon.despachaElegancia()) 
        return nuevoDon
    else return null
  }
}