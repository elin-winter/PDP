// ------------------------- Contenido

class Texto {
    const textoMensaje
    
    method peso() = textoMensaje.size()
    method contiene(texto) = textoMensaje.contains(texto)
}

class Audio {
  const duracionEnSegs
  const valorXSeg = 1.2

  method peso() = duracionEnSegs * valorXSeg
  method contiene(texto) = false
}

class Contacto {
    const usuarioEnviado
    const pesoFijo = 3

    method peso() = pesoFijo
    method contiene(texto) = usuarioEnviado.contains(texto)
}

class Imagen{
    const altoEnPixel
    const anchoEnPixel
    const modoCompresion

    const pesoPixel = 2

    const cantPixeles = altoEnPixel * anchoEnPixel

    method peso() = modoCompresion.comprimi(cantPixeles) * pesoPixel
    method contiene(texto) = false
}

class Gif inherits Imagen {
    const cantCuadros

    override method peso() = super() * cantCuadros
}


// ------------------------- Compresion

object compresionOriginal{
    method comprimi(cantPixeles) = cantPixeles
}

object compresionVariable{
    const porcentajesPosibles = [0-100]
    method comprimi(cantPixeles) = 
        cantPixeles * porcentajesPosibles.anyOne()
}

object compresionMaxima{
    const cantMaxPixeles = 10000

    method comprimi(cantPixeles) =
        cantPixeles.min(cantMaxPixeles)
}