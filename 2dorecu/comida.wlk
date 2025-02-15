class Comida{
    var calidad
    const receta
    method recetaDeLaComida() = receta
  method calidad() = calidad
    method esDificil(){
        return receta.esDificil()
    }
    method ingredientesDeLaComida(){
        return receta.ingredientes()
    }

    method experienciaDeLaComida(){
        calidad.experiencia(receta)
    }
    method settearCalidad(unaCalidad){
        calidad = unaCalidad
    }
    method settearPlus(unPlus){
        calidad.setplus(unPlus)
    }
    
}
object  normal{
    method experiencia(unaReceta){
        return unaReceta.experienciaNormal()
    }
}
class Pobre{
var valorDeExperienciaMax
method settearValorMax(unValor){
    valorDeExperienciaMax = unValor 
}
method experiencia(unaReceta){
return unaReceta.experieciaNormal() - valorDeExperienciaMax
}

}
class Superior{
    var plus
    
    method setPlus(unPlus){
        plus = unPlus
    } 

    method experiencia(unaReceta){
        return unaReceta.experienciaNormal() + plus
    }
}