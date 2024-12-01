// ------------------------- Superclase

class Persona {

    var edad
    var cantMonedas = 20

    method ganarMonedas(cant) { cantMonedas += cant }
    method gastarMonedas(cant) {self.ganarMonedas(-cant)}
    method cumplirAnios() { edad += 1}
    
    method edad(nuevaEdad) { // solo para test
        edad = nuevaEdad
    }

    method recursos() = cantMonedas
    
    method esDestacada() = 
        edad.between(18, 65) or cantMonedas > 30
    
    method trabajar(_, __) {}
}

// ------------------------- Tipos de Personas

class Productor inherits Persona {

    const planetaHogar

    const tecnicas = ["Cultivo"]

    method aprenderTecnica(nuevaTecnica) {
        tecnicas.add(nuevaTecnica)
    }

    override method recursos() = super() * tecnicas.size()

    override method esDestacada() =
        super() or tecnicas.size() > 5
    
    method realizarTecnica(tecnica, tiempo) {
        if(self.conoce(tecnica)) self.ganarMonedas(3 * tiempo) 
        else self.gastarMonedas(1)
    }

    override method trabajar(tiempo, planeta) {
        if(planetaHogar == planeta) self.realizarTecnica(tecnicas.last(), tiempo)
    }

    method conoce(tecnica) = tecnicas.contains(tecnica)
}

class Constructor inherits Persona {
    const inteligencia
    const regionHogar

    var cantConstruc = 0

    method inteligencia() = inteligencia

    method construir() {
        cantConstruc += 1
    }

    override method recursos() = 
        super() + 10 * cantConstruc
    
    override method esDestacada() = cantConstruc > 5

    override method trabajar(tiempo, planeta) {
        planeta.agregarConstruccion(regionHogar.construye(tiempo, self))
    }

}


