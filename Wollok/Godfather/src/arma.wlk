// -------------------- Armas

class Revolver {
  var cantBalas 

  method accionar(persona) {
    if(cantBalas != 0) {
      persona.morir()
      cantBalas -= 1
    } 
  }

  method sutil() = cantBalas == 1
}

class Escopeta {
  method accionar(persona) {
    if(persona.herida()) persona.morir()
    else persona.herida(true)
  }

  method sutil() = false
}

class CuerdaPiano {
  const buenaCalidad

  method accionar(persona) {
    if(buenaCalidad) persona.morir()
  }

  method sutil() = true
}