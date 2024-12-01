class Planeta {
    const habitantes
    const construcciones

    method agregarConstruccion(construccion) {
        construcciones.add(construccion)
    }

    method delegacioDiplomatica() = habitantes.filter({h => self.condDiplomacia(h)}).asSet()

    method condDiplomacia(habitante) =
        habitante.esDestacada() or self.habitanteMasRecursos(habitante)
    
    method habitanteMasRecursos(habitante) = 
        habitante == habitantes.max({h => h.recursos()})
    
    method esValioso() = construcciones.sum {c => c.valor()} > 100

    method delegacionTrabaja(tiempo, planeta) {
        self.delegacioDiplomatica().forEach({p => p.trabajar(tiempo, planeta)})
    }

    method invadir(planeta, tiempo) {
        planeta.delegacionTrabaja(tiempo, planeta)
    }  
}