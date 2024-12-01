import platos.*

class Cocinero {
    var especialidad

    method cambiarEspecialidad(nuevaEsp) {
        especialidad = nuevaEsp
    }

    method catar(plato) = especialidad.calificar(plato)
    
    method cocinar() = especialidad.generarPlato()
}

class EspecialidadPastelero {
    const nivelDeseadoDulzor

    method calificar(plato) = (5 * plato.cantAzucar() / nivelDeseadoDulzor).min(10)

    method generarPlato() = new Postre(cantColores = nivelDeseadoDulzor / 50)
    
}

class EspecialidadChef{
    const cantCalorias
    const maxCalificacion = 10
    const minCalificacion = 0

    method platoCumpleExpectativas(plato) = plato.esBonito() and plato.calorias() <= cantCalorias

    method calificar(plato) =
        if(self.platoCumpleExpectativas(plato))
            maxCalificacion
        else
            self.platoNoCumple(plato)
    
    method platoNoCumple(plato) = minCalificacion

    method generarPlato() = new Principal(cantAzucar = cantCalorias, esBonito = true)
    
}

class EspecialidadSousChef inherits EspecialidadChef {
    override method platoNoCumple(plato) = (plato.calorias() / 100).min(6)

    override method generarPlato() = new Entrada()
}

