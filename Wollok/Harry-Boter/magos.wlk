import aceites.*
import bots.*
import casas.*
import hogwarts.*
import materias.*
import hechizos.*

class Mago inherits Bot {
    
    var property casaDeHogwarts = null
    const hechizosConocidos = []

    method loConoce(hechizo) = hechizosConocidos.contains(hechizo)

    method lanzarHechizo(hechizo, victima) {
        if(self.puedeLanzarHechizo(hechizo)) hechizo.aplicar(victima)
    }

    method puedeLanzarHechizo(hechizo) = 
        self.loConoce(hechizo) and hechizo.cumpleConds(self) and self.estarActivo()

    method ultHechizoConocido() = hechizosConocidos.last()

    method esExperimentado() = 
        hechizosConocidos.size() > 3 and cargaElectrica > 50

}

// --------------- Subclases

class Estudiante inherits Mago {

    method asistirMateria(materia) {
        hechizosConocidos.add(materia.hechizoEnseniado())
    }

    override method puedeSerAdmitidoHogwarts() = true
}

class Profesor inherits Mago {

  const materiasDadas = []

  method agregarMateria(nuevaMateria) {
    materiasDadas.add(nuevaMateria)
  }

  override method esExperimentado() = super() and materiasDadas.size() >= 2
  override method puedeDictarClases() = true

  override method efectoDisminuirCarga(valor) {
    if(valor == cargaElectrica) cargaElectrica /= 2
  }

}