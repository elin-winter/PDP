// ------------------------- Chat

class Chat {
    var participantes
    const mensajesEnviados = []

    method validarEnvio(usuario, mensaje) = 
        participantes.contains(usuario) and self.usuariosConMmria(mensaje)

    method usuariosConMmria(mensaje) =
        participantes.all({x => self.tieneMemoriaSufic(x, mensaje)})
    
    method tieneMemoriaSufic(usuario, mensaje) = 
        usuario.memoria() >= mensaje.pesoMensaje()
    
    method recibirMensaje(mensaje) {
        participantes.forEach({x => self.participanteRecibeMsj(x, mensaje)})
        mensajesEnviados.add(mensaje)
    }

    method participanteRecibeMsj(usuario, mensaje) {
        usuario.variarMemoria(-mensaje.pesoMensaje())
        usuario.recibirNoti(new Notificacion(
            chat = self, 
            emisor = mensaje.emisor(), 
            mensaje = mensaje))
    }

    method espacioOcupado() = 
        mensajesEnviados.sum {x => x.pesoMensaje()}
    
    method busquedaTexto(texto) = mensajesEnviados.any({x => x.contiene(texto)})

    method mensajeMasPesado(usuario) = self.enviadosPor(usuario).max({x => x.pesoMensaje()})

    method enviadosPor(usuario) = mensajesEnviados.filter({x => x.emisor() == usuario})
}

class ChatPremium inherits Chat {
    
    var restriccionAdicional
    const creadorChat
    var cantMensajesEnviados

    method creadorChat() = creadorChat
    method cantMensajesEnviados() = cantMensajesEnviados

    method participantes(nuevosParticipantes) {
        participantes = nuevosParticipantes
    }

    method restriccionAdicional(nuevaRest) {
        restriccionAdicional = nuevaRest
    }

    override method validarEnvio(usuario, mensaje) =
        super(usuario, mensaje) and restriccionAdicional.restringir(usuario, mensaje, self)
    
    override method recibirMensaje(mensaje) {
        super(mensaje)
        cantMensajesEnviados += 1
    }

}

// ------------------------- Restriccion

object difusion {
    method restringir(usuario, _, chat) = 
        usuario == chat.creadorChat()
}

class Restringido{
    const limiteMensajes

    method restringir(_, __, chat) = limiteMensajes < chat.cantMensajesEnviados()
}

class Ahorro{
    const pesoMax

    method restringir(_, mensaje, chat) = 
        mensaje.pesoMensaje() < pesoMax
}

// ------------------------- Notificacion

class Notificacion {
    const chat
    const emisor
    const mensaje

    method chat() = chat
}

