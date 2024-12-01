// Apellido y Nombre: Winter Elin

// --------------------------------------- Departamento de Muerte

object departamentoDeLaMuerte {

    // -------------------- Referencias

    var agentes = []

    // -------------------- Metodos

    // Accessors

    method agregarEmpleado(nuevoEmpleado) {
        agentes.add(nuevoEmpleado)
    }

    // Consulta

    method mejorAgente() = agentes.max({agente => agente.cantVentas()}) // PUNTO 1B

    // Efecto

    method ocurreDiaDeMuertos() { // PUNTO 2
        self.reducirDeudaMejorAgente()
        self.liberarAgentesSinDeuda()
        self.aumentarDeudaDeAgentes()
    }

    method reducirDeudaMejorAgente() = 
        self.mejorAgente().variarDeuda(-50)
    
    method liberarAgentesSinDeuda() {
        agentes = agentes.filter({x => x.tieneDeuda()}) // los libera porque los saca de su lista de agentes
    }

    method aumentarDeudaDeAgentes() {
        agentes.forEach({x => x.variarDeuda(100)}) // los que quedan son los que siguen teniendo deuda, asi que les aumento a todos
    }
}