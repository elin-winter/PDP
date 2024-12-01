// Apellido y Nombre: Winter Elin

import paquete.*

// --------------------------------------- Estrategias

object clasico {
    method elegirPaquete(alma, paquetes) {
        const paquetesPosibles = self.paquetesCosteables(alma, paquetes)
        return paquetesPosibles.max({paquete => paquete.costo(alma)})
    }

    method paquetesCosteables(alma, paquetes) = 
        paquetes.filter({paquete => alma.puedeCostearlo(paquete)})
}

object navegante {

    method elegirPaquete(alma, _) {
        const cantAccionesBuenas = alma.cantAccionesBuenas()

        if(cantAccionesBuenas >= 50) 
            return new PaqueteCrucero(valorBasico = cantAccionesBuenas)
        else 
            return new PaqueteBote(valorBasico = cantAccionesBuenas)
    }    
}

object indiferente {
    method elegirPaquete(alma, paquetesPredefinidos) =
        new PaquetePaloBrujula(valorBasico = self.nroRandom())
    
    method nroRandom() = 1.randomUpTo(300)
}