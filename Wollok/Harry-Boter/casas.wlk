import aceites.*
import bots.*
import magos.*
import hogwarts.*
import materias.*
import hechizos.*

// --------------- Superclase

class CasaDeHogwarts {
  const esPeligrosa 
  var estudiantes = []

  method nuevoEstudiante(estudiante) {
    estudiantes.add(estudiante)
  }

  method esPeligrosa() {
    if(esPeligrosa == null) return self.otraPeligrosidad()
    return esPeligrosa
  }

  method otraPeligrosidad() = 
    self.cantEstudiantesSucios() > estudiantes.size()/2

  method cantEstudiantesSucios() {
    return estudiantes.filter({x => x.aceiteSucio()}).size()
  }

  method estudiantes() = estudiantes
}

// --------------- Instancias

const gryffindor = new CasaDeHogwarts (esPeligrosa = false)
const slytherin = new CasaDeHogwarts (esPeligrosa = true)
const ravenclaw = new CasaDeHogwarts (esPeligrosa = null) 
const hufflepuff = new CasaDeHogwarts (esPeligrosa = null)