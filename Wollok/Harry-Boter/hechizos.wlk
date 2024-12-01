import aceites.*
import bots.*
import casas.*
import magos.*
import hogwarts.*
import materias.*

class Hechizo {

  const deltaCarga = 0

  method aplicar(victima) {
    victima.efectoDisminuirCarga(deltaCarga)
  }

  method cumpleConds(bot) = bot.cargaElectrica() > deltaCarga
}

object inmobilus inherits Hechizo (deltaCarga = 50) {

  override method cumpleConds(bot) = true

}

object sectumSembra inherits Hechizo {
  override method aplicar(victima) {
    victima.hacerImpuroAceite()
  }

  override method cumpleConds(bot) = bot.esExperimentado()
}

object avadakedabra inherits Hechizo{
  
  override method aplicar(victima) {
    victima.efectoDisminuirCarga(victima.cargaElectrica())
  }

  override method cumpleConds(bot) =
    bot.aceiteSucio() and bot.casaDeHogwarts().esPeligrosa()
}

object superEnseniadorki inherits Hechizo{

  const hechizos = [inmobilus, sectumSembra, avadakedabra]
  override method aplicar(victima) {
    hechizos.forEach({x => victima.hechizosAprendidos().add(x)})
  }

  override method cumpleConds(bot) =
    hechizos.any({x => bot.loConoce(x)})
}

const hechizoGenerico = new Hechizo (deltaCarga = 90)