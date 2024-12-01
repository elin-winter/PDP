// ------------------------- Recuerdos

class Recuerdo {
    const desc
    const fecha
    const emocionDominante
    var property pensamientoCentral = false

    method fecha() = fecha
    method descContiene(palabra) = desc.contains(palabra)

    method emocionDominante() = emocionDominante
    method dificilExplicar() = self.cantPalabras() > 10
    
    method cantPalabras() = desc.ocurrencesOf(" ") + 1

}