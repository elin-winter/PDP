import fiesta_empresa.*
import lenguajes.*

class Trabajador {
  const property lenguajesConocidos
  var jefes
  const valorRegalo = 1000

  method esJefe() = false
  method esAsistente() = false
  method estaParaInvitar() = self.esCopado()
  method esCopado() = false

  method conoceLenguajeAntiguo() = self.conoceLenguajeProp({x => x.esLenguajeAntiguo()})
  method conoceLenguajeModerno() = self.conoceLenguajeProp({x => !x.esLenguajeAntiguo(x)})
  
  method conoceLenguajeProp(codigo) = lenguajesConocidos.any(codigo) 

  method cantLenguajesModernos() {
    return lenguajesConocidos.count({x => !x.esLenguajeAntiguo()})
  }

  method agregarJefe(jefe) {
    jefes.add(jefe)
  }

  method aprenderLenguaje(lenguaje) {
    lenguajesConocidos.add(lenguaje)
  }

  method regalo() = valorRegalo
  method mesa() = self.cantLenguajesModernos()

} 

class Desarrollador inherits Trabajador{

  override method estaParaInvitar() = 
    super() || self.programaEnWollok() || self.conoceLenguajeAntiguo() 

  method programaEnWollok() = lenguajesConocidos.contains(wolloki)

  override method esCopado() = 
    self.conoceLenguajeAntiguo() and self.conoceLenguajeModerno()
  

}

class Infraestructura inherits Trabajador {

  var experiencia

  override method estaParaInvitar() = 
    super() || lenguajesConocidos.size() >= 5

  override method esCopado() = experiencia > 10

}

class Jefe inherits Trabajador {

  var personasACargo
  

  override method esJefe() = true

  override method estaParaInvitar() = 
    self.conoceLenguajeAntiguo() and self.soloEmpleadosCopados()
  
  method soloEmpleadosCopados() = personasACargo.all({x => x.esCopado()})

  method agregarEmpleado(empleado) {
    personasACargo.add(empleado)
  }

  override method regalo() = super() + self.adicionalRegalo()
  method adicionalRegalo() = valorRegalo * personasACargo.size()
  override method mesa() = 99

}