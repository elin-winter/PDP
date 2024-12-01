// Apellido y Nombre: Winter Elin

// --------------------------------------- Agentes de Viajes

class AgenteDeViaje {

    // -------------------- Referencias
    
    const paquetesPredefinidos
    var estrategia
    var deuda

    const costoPaquetesVendidos = []

    // -------------------- Metodos

    // Accessors

    method variarDeuda(delta) { deuda += delta }

    method estrategia(nuevaEstrategia) {  // Porque se puede cambiar en cualquier momento
        estrategia = nuevaEstrategia
    }

    // Consulta

    method dineroTotalGanado() = costoPaquetesVendidos.sum() // PUNTO 1C
    
    method deudaActual() = deuda // PUNTO 1D

    method cantVentas() = costoPaquetesVendidos.size()
    
    method tieneDeuda() = deuda > 0

    method armarPaquete(alma) = 
        estrategia.elegirPaquete(alma, paquetesPredefinidos)

    // Efecto

    method venderPaqueteViaje(alma, paquete) { // PUNTO 1A
        if(alma.puedeCostearlo(paquete)) {
            costoPaquetesVendidos.add(paquete.costo(alma))
            self.variarDeuda(-paquete.costo(alma))
        } 
    }

    method atenderAlma(alma) { // PUNTO 4
        const paquete = self.armarPaquete(alma)
        self.venderPaqueteViaje(alma, paquete)
    }
}