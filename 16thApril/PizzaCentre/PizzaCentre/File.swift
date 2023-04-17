enum PizzaType {
    case Small
    case Medium
    case Large
}

enum ToppingsType {
    case Cheese
    case Pepperoni
    case Ham
    case None
}

struct Pizza {
    let pType: PizzaType
    let tType: ToppingsType
    
    init(pType: PizzaType, tType: ToppingsType) {
        self.pType = pType
        self.tType = tType
    }
    
    func priceInfo() -> Double {
        switch(pType,tType) {
        case (.Small,.Cheese):
            return 100
        case (.Medium, .Cheese):
            return 200
        case (.Large, .Cheese):
            return 300
        case (.Small, .Pepperoni):
            return 150
        case (.Medium, .Pepperoni):
            return 175
        case (.Large, .Pepperoni):
            return 190
        case (.Small, .Ham):
            return 210
        case (.Medium, .Ham):
            return 230
        case (.Large, .Ham):
            return 240
        case (.Small, .None):
            return 55
        case (.Medium, .None):
            return 65
        case (.Large, .None):
            return 75
        }
    }
}

struct PizzaOrder {
    func order(pizza: Pizza) {
        print("Order:")
        print("Type:\(pizza.pType)--")
        print("Toppings:\(pizza.tType)--")
        print("Price:\(pizza.priceInfo())--")
    }
}
