class Receta{
    const nivelDeDificultad
    const ingredientes =[]
    
    method nivelDeDificultad()= nivelDeDificultad
    
    method cantidadIngredientes()=ingredientes.size()

    method esDificil() = self.nivelDeDificultad() > 5 || self.cantidadIngredientes() > 10
    
    method ingredientes()=ingredientes
    
    method experienciaNormal(){
        return self.cantidadIngredientes() * self.nivelDeDificultad()
    }
}

class RecetaGourmet inherits Receta{
    override method experienciaNormal(){
        return super() * 2
    }
    override method esDificil() = true
}