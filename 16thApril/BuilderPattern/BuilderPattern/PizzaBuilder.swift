class PizzaBuilder {
    private var size: String = ""
    private var cheese: Bool = false
    private var pepperoni: Bool = false
    private var mushrooms: Bool = false
    
    func setSize(_ size: String) -> PizzaBuilder {
        self.size = size
        return self
    }
    
    func setCheese(_ cheese: Bool) -> PizzaBuilder {
        self.cheese = cheese
        return self
    }
    
    func setPepperoni(_ pepperoni: Bool) -> PizzaBuilder {
        self.pepperoni = pepperoni
        return self
    }
    
    func setMushrooms(_ mushrooms: Bool) -> PizzaBuilder {
        self.mushrooms = mushrooms
        return self
    }
    
    func build() -> Pizza {
        Pizza(size: size, cheese: cheese, pepperoni: pepperoni, mushrooms: mushrooms)
    }
    
}


