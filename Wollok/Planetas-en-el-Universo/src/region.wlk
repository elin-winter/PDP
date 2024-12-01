
import construccion.*

object montania {
    method construye(tiempo, _) = new Muralla(longitud = tiempo/2)
}

object costa {
    method construye(tiempo, _) =
        new Museo(supCubierta = tiempo/2).indiceImportancia(1)
}
object llanura {
    method construye(tiempo, persona) =
        if(persona.esDestacada()) new Museo(
            supCubierta = tiempo).indiceImportancia(
                persona.recursos())
        
        else new Muralla(longitud = tiempo / 2)
}
object pampaArgentina {
    method construye(tiempo, persona) = new Muralla(
        longitud = persona.inteligencia() * tiempo)
}