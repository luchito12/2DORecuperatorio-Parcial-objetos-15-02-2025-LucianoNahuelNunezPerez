import comida.*
class Cocinero{
    const preparaciones=[] //lista De Comidas Que Preparo
    var experiencia
    method nivelExperiencia()= experiencia
    var nivelAprendizaje = Pricipiante

    method settearAprendizaje(nuevoNivel){
        nivelAprendizaje = nuevoNivel
    }
    method agregarComida(unaComida){
        preparaciones.add(unaComida)
    }

    method cantidadDeComidasConRecetasSimilares(nuevaReceta){ //este metodo tiene que hacer sumar las recetas que son similares
       return self.recetasDeMisComidas().esSimilar(nuevaReceta).sum()
    }
    method recetasDeMisComidas(){
        return preparaciones.filter({unaComida => unaComida.recetaDeLaComida()})  //retorna lista con las recetas de mis comidas 
    }
    method experienciaDeMisComidas(){
        return preparaciones.sum({unaPreparacion => unaPreparacion.experienciaDeLaComida()})
    }
    method esSimilar(nuevaReceta){
        return self.recetasDeMisComidas().any({unaRecetaPreparada => unaRecetaPreparada.ingredientes() == nuevaReceta.ingredientes() })
    }
    method dificultadParecida(unaReceta){
        return self.recetasDeMisComidas().any({unaRecetaPreparada => (unaRecetaPreparada.nivelDeDificultad() - unaReceta.nivelDeDificultad()).abs() <=1 }) //con el abs obtengo el valor absoluto asi no queda negativo y no hay problemas
    }

    method superoNivelDeAprendizaje(){ //Punto 2 
        nivelAprendizaje.superaNivel(self)
    }

    method preparoMasDeXComidasDificiles(unaCantidad){
        self.comidasDificiles().size() > unaCantidad
    }
    method comidasDificiles(){
        return preparaciones.filter({unaPreparacion => unaPreparacion.esDificil()})
    }
    method preparar(unaComida, unaReceta){ //punto 3
        nivelAprendizaje.puedePreparar(unaReceta, self) //veo si la puede preparar segun nivel
        nivelAprendizaje.puedeElaborar(unaComida, self) // veo la calidad de la comida
        self.agregarComida(unaComida) //agrego la comida a preparaciones
        self.adquirirExperiencia(unaComida.experienciaDeLaComida()) //adquiero la experiencia de la comida luego de que settie su calidad
        nivelAprendizaje.subirNivel(self) //subo mi nivel 
    }

    method adquirirExperiencia(unaExperiencia){
        experiencia = unaExperiencia
    }
    method recetaConMasXp(){
        return self.recetasDeMisComidas().max({unaReceta => unaReceta.experienciaNormal()})
    }
}
class Pricipiante{
    method puedePreparar(unaReceta, unCociero){
    return !unaReceta.esDificil()
    } 
    method puedeElaborar(unaComida, unCocinero){
        if(unaComida.ingredientesDeLaComida()< 4){
            return unaComida.settearCalidad(normal)
        }else{
            unaComida.settearCalidad(Pobre)
        }
    }
    method superaNivel(unCocinero){
        return unCocinero.nivelExperiencia() > 100
    }
    method subirNivel(unCocinero){
        if(self.superaNivel(unCocinero)){
            unCocinero.settearAprendizaje(Experimentado)
        }
    }
}

class Experimentado inherits Pricipiante{
    override method puedePreparar(unaReceta, unCocinero){
        return super(unaReceta, unCocinero) || self.esSimilar(unaReceta,unCocinero)
    }
    method esSimilar(unaReceta, unCocinero){
        return unCocinero.esSimilar(unaReceta) || unCocinero.dificultadParecida(unaReceta)
    }

    override method puedeElaborar(unaComida, unCocinero){
        if(self.logroPerfeccionar(unaComida, unCocinero)){
            unaComida.settearCalidad(Superior) 
            unaComida.settearPlus(unCocinero.cantidadDeComidasConRecetasSimilares(unaComida.recetaDeLaComida()) / 2) 
        }else{
            unaComida.settearCalidad(normal)
        }
    }
    method logroPerfeccionar(unaComida, unaCocinero){
        return unaCocinero.nivelExperiencia() == unaComida.experienciaDeLaComida() * 3 //la experiencia es el triple de lo que aporta la comida
    }
    override method superaNivel(unCocinero){
        return unCocinero.preparoMasDeXComidasDificiles(5)
    }
     override method subirNivel(unCocinero){
        if(self.superaNivel(unCocinero)){
            unCocinero.settearAprendizaje(Chef)
        }
    }
}

class Chef inherits Experimentado{
override method puedePreparar(unaReceta, unCocinero){
    return true 
}

override method superaNivel(unCocinero){
        return true
    }

 override method subirNivel(unCocinero){
        if(self.superaNivel(unCocinero)){
            unCocinero.settearAprendizaje(self) //retorna a si mismo Por que no hay un nivel mas arriba 
        }
    }

}