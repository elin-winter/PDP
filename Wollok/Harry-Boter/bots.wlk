import aceites.*
import casas.*
import magos.*
import hogwarts.*
import materias.*
import hechizos.*

class Bot {
  
    var property cargaElectrica
    const estadoAceite
    const aceite = new Aceite(esPuro = estadoAceite)

    method estarActivo() = cargaElectrica > 0
    method aceiteSucio() = !aceite.esPuro()

    
    method cargaMayorA(valor) = cargaElectrica > valor
    method puedeDictarClases() = false
    method puedeSerAdmitidoHogwarts() = false

    method efectoDisminuirCarga(valor) {
        cargaElectrica -= valor
    }
    method hacerImpuroAceite() {aceite.hacerImPuro()}

}

// --------------- WKOs que heredan

object sombreroSeleccionador inherits Bot (cargaElectrica = 10, estadoAceite = true) {
  
  const casasPosibles = [gryffindor, slytherin, ravenclaw, hufflepuff]
  var indice = -1
  
  method asignarEstudiante(estudiante) {
    
    const casaAsignada = casasPosibles.get(self.indiceActual())
    estudiante.casaDeHogwarts(casaAsignada)
    casaAsignada.nuevoEstudiante(estudiante) 
        
  }

  method indiceActual() {
    indice = indice + 2
    if(indice > casasPosibles.size()) {indice = 0}
    return indice
  }

  override method hacerImpuroAceite() {}

}