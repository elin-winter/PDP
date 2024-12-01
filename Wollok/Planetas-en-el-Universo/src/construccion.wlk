class Muralla {
    const longitud
    const valorFijo = 10

    method valor() = valorFijo * longitud
} 

class Museo {
    const supCubierta
    var indiceImportancia = 0

    method indiceImportancia(valor) {
        indiceImportancia = valor.max(1).min(5)
    }

    method valor() = 
        if(indiceImportancia == 0)
            throw new DomainException (message = "Falta inicializar Indice de Importancia")
        else  supCubierta * indiceImportancia
}

