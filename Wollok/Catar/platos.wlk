import chefs.*

class Plato {
  const caloriasBase = 100

  method cantAzucar() 
  method esBonito()

  method calorias() = 3 * self.cantAzucar() + caloriasBase

}

class Principal inherits Plato {
  const cantAzucar
  const esBonito

  override method cantAzucar() = cantAzucar
  override method esBonito() = esBonito
}

class Entrada inherits Plato {
  override method cantAzucar() = 0
  override method esBonito() = true
}

class Postre inherits Plato {
  const cantColores
  const cantAzucar = 120

  override method cantAzucar() = cantAzucar
  override method esBonito() = cantColores > 3
}