class Usuario {

    var memoria
    const chatsQueTiene
    const notificaciones = []

    method memoria() = memoria

    method variarMemoria(delta) {
        memoria += delta
    }

    method agregarChat(chat) {
        chatsQueTiene.add(chat)
    }
    
    method enviarMensaje(mensaje, chat) {
        if(chat.validarEnvio(self, mensaje)) {
            chat.recibirMensaje(mensaje)
        } else 
            throw new DomainException(message = "Usuario no puede enviar este mensaje")
    } 

    method busquedaTexto(texto) = 
        chatsQueTiene.filter({x => x.busquedaTexto(texto)})
    
    method mensajesMasPesados() = 
        chatsQueTiene.map({x => x.mensajeMasPesado(self)})

    method recibirNoti(noti) {
        notificaciones.add(noti)
    }

    method leerChat(chat) {
        notificaciones.removeAllSuchThat({x => x.chat() == chat})
    }

    method notisSinLeer() = notificaciones
}