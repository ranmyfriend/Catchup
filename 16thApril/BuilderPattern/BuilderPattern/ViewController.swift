import UIKit

/*
 
 Builder class properties and model properties are not the same, although they may share similar names or types.

 In the Builder pattern, the purpose of the builder class is to provide a flexible and extensible way to construct complex objects. The builder class typically has its own set of properties that are used to build the final object, but these properties may differ from the properties of the object being built.

 The builder class is used to separate the construction of an object from its representation, allowing you to create different variations of the object without having to modify the object's class. By using a builder, you can also ensure that the object being built is always in a valid state before it is used.
 
 */

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pizza = PizzaBuilder()
            .setSize("7inch")
            .setCheese(true)
            .setPepperoni(false)
            .setMushrooms(true)
            .build()
        
        print(pizza)
        
        
        let person = PersonBuilder()
            .setFirstName("ranjith")
            .setLastName("kumar")
            .setAge(33)
            .setPhone(9704963170)
            .setAddress("Bangalore")
            .build()
        
        print(person)
        
        let jobs = PersonBuilder()
            .setFirstName("Steve")
            .setLastName("Jobs")
            .setAge(56)
            .setPhone(9956789)
            .build()
        
        print(jobs)
        
        
        
    }


}



