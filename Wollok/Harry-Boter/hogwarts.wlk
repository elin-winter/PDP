import aceites.*
import bots.*
import casas.*
import magos.*
import materias.*
import hechizos.*

class UserException inherits wollok.lang.Exception {}

object hogwarts {
	var materiasDisponibles = []
	
	method asignarCasasEstudiantes(grupo) {
		grupo.forEach({x => sombreroSeleccionador.asignarEstudiante(x)})
	}
	
	method grupoAsisteAMateria(grupo, materia) {
		grupo.forEach({x => x.asistirMateria(materia)})
	}
	
	method crearUnaMateria(prof, hechizo) {
		if(prof.puedeDictarClases())
		{
			const materiaNueva = new Materia(profACargo = prof, hechizoEnseniado = hechizo)
			prof.agregarMateria(materiaNueva)
			
			return materiaNueva
		}
		else
			throw new UserException(message = "Un bot o un estudiante no puede dar una clase!")
	}

    method estudiantesDeCasaLanzanUltHechizoAlInnombrable(casa) {
        casa.estudiantes().forEach({ x => x.lanzarHechizo(x.ultHechizoConocido(), innombrable)})
    }
}

const innombrable = new Mago(cargaElectrica = 1000, estadoAceite = true)

