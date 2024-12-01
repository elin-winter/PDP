// Apellido y Nombre: Winter Elin

// --------------------------------------- Paquetes

// PUNTO 3

class Paquete {

    // -------------------- Referencias

    const valorBasico

    // -------------------- Metodos

    // Accessors

    method valorBasico() = valorBasico // para tests

    // Consulta

    method costo(alma) = self.costoBasico(alma).min(350) 

    method costoBasico(alma) = valorBasico * self.cantAniosReduceViaje(alma)

    // Sobrescritos en las Subclases

    method cantAniosReduceViaje(alma)
         
}

class PaqueteTren inherits Paquete {
    override method cantAniosReduceViaje(_) = 4
}

class PaqueteBote inherits Paquete {
    override method cantAniosReduceViaje(alma) = 
        (alma.cantAccionesBuenas() / 50).min(2)
}

class PaqueteCrucero inherits PaqueteBote {
    override method cantAniosReduceViaje(alma) = super(alma) * 2
}

class PaquetePaloBrujula inherits Paquete {
    override method cantAniosReduceViaje(_) = 0.05
    override method costo(_) = valorBasico 
}
