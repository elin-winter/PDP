class Mensaje {

  const emisor
  const contenido

  const factorRed = 1.3
  const datosFijos = 5

  method emisor() = emisor

  method pesoMensaje() = 
    datosFijos + contenido.peso() * factorRed
  
  method contiene(texto) = emisor.contains(texto) or contenido.contiene(texto)
  
}

