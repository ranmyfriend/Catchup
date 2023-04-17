struct Pizza {
    private let size: String
    private let cheese: Bool
    private let pepperoni: Bool
    private let mushrooms: Bool
    
    init(size: String, cheese: Bool, pepperoni: Bool, mushrooms: Bool) {
        self.size = size
        self.cheese = cheese
        self.pepperoni = pepperoni
        self.mushrooms = mushrooms
    }
}
