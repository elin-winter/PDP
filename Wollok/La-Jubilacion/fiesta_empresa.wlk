import empleados.*
import lenguajes.*

object fiestaJubilacion {

  const costoFijo = 200000
  const costoXPersona = 5000
  const listaInvitados = self.obtenerListaInvitados()
  const registrosAsistencia = []

  method empleadoInvitado(empleado) = listaInvitados.contains(empleado)
  method obtenerListaInvitados() {
    return empresa.personal().filter({x => x.estaParaInvitar()})
  }

  method registrarAsistencia(empleado) {
    if(self.empleadoInvitado(empleado)) {
      registrosAsistencia.add(new registroAsistencia(invitado = empleado, nroMesa = empleado.mesa()))
    }
  }

  method calcularBalance() = costoFijo + self.costoPorInvitados() - self.sumaDeRegalos()

  method costoPorInvitados() = 
    listaInvitados.size() * costoXPersona
  
  method sumaDeRegalos() = registrosAsistencia.map({x => x.invitado().regalo()}).sum()

  method fueUnExito() = self.calcularBalance() > 0 and self.todosInvitadosAsistieron()

  method todosInvitadosAsistieron() = 
    listaInvitados.size() == registrosAsistencia.size()
  
  /*
  method mesaConMasPersonas()

  */

}

object empresa {

  const property personal = []

  method jefeTomeACargoEmpleado(jefe, empleado) {
    jefe.agregarEmpleado(empleado)
    empleado.agregarJefe(jefe)
  }

  method empleadoAprendeLenguaje(empleado, lenguaje) {
    empleado.aprenderLenguaje(lenguaje)
  }
}

class registroAsistencia {
  const invitado
  const nroMesa

  method invitado() = invitado
  method nroMesa() = nroMesa
}
