import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let car = Car()
//        let motorbike = Motorbike()
//        let lorry = Lorry()
//        let bus = Bus()
        let car = Vechicle.makeVechicle(type: .car)
        let motorbike = Vechicle.makeVechicle(type: .motorbike)
        let lorry = Vechicle.makeVechicle(type: .lorry)
        let bus = Vechicle.makeVechicle(type: .bus)
    
//        let vechicles: [Vechicle] = [car, motorbike, lorry, bus]
        
//        for vechicle in vechicles {
//            print(vechicle.serviceCharge())
//        }
        
        
        let vechicles: [VechicleProtoo] = [Car(), Motorbike(), Lorry(), Bus()]
        
//        VehicleInspector inspector = new VehicleInspection();
        let inspector: VechicleInspectorProto = VechicleInspection()
        
        for vechicle in vechicles {
//            print(vechicle.serviceCharge())
            print(vechicle.accept(vehicleInspector: inspector))
        }
        
    }

}

//Objects and Data Structures
/*
 Objects hide their data behind abstractions and expose functions that operate on that data. Data struc- ture expose their data and have no meaningful functions.
 */

public class Point {
    public let x: Double
    public let y: Double
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

public protocol PointProto {
    func getX() -> Double
    func getY() -> Double
    func setCartesian(x: Double, y: Double)
    func getR() -> Double
    func getTheta() -> Double
    func setPolar(r: Double, theta: Double)
}

public class Square: NSObject {
    public let topLeft: Point
    public let side: Double
    
    init(topLeft: Point, side: Double) {
        self.topLeft = topLeft
        self.side = side
    }
}
public class Rectangle: NSObject {
    public let topLeft: Point
    public let height: Double
    public let width: Double
    
    init(topLeft: Point, height: Double, width: Double) {
        self.topLeft = topLeft
        self.height = height
        self.width = width
    }
}
public class Circle: NSObject {
    public let center: Point
    public let radius: Double
    
    init(center: Point, radius: Double) {
        self.center = center
        self.radius = radius
    }
}


public class Geometry {
    public final let PI: Double = 3.141592653589793
    public func area(shape: NSObject) throws -> Double {
        if (shape is Square) {
            let s: Square = shape as! Square
            return s.side * s.side
        } else if (shape is Rectangle) {
            let r: Rectangle = shape as! Rectangle
            return r.height * r.width
        } else if (shape is Circle) {
            let c: Circle = shape as! Circle
            return PI * c.radius * c.radius
        }
        throw NSException() as! Error
    }
    
}

/*
 Object-oriented programmers might wrinkle their noses at this and complain that it is procedural—and they’d be right. But the sneer may not be warranted. Consider what would happen if a perimeter() function were added to Geometry. The shape classes would be unaffected! Any other classes that depended upon the shapes would also be unaffected! On the other hand, if I add a new shape, I must change all the functions in Geometry to deal with it. Again, read that over. Notice that the two conditions are diametrically opposed.
 */


/* Solving here: */

protocol ShapeProto {
    func area() throws -> Double
//    func perimeter()
}

public class Squaree: ShapeProto {
    private let topLeft: Point
    private let side: Double
    init(topLeft: Point, side: Double) {
        self.topLeft = topLeft
        self.side = side
    }
    
    public func area() -> Double {
        return side*side
    }
}
    

public class Rectanglee: ShapeProto {
    private let topLeft: Point
    private let height: Double
    private let width: Double
    init(topLeft: Point, height: Double, width: Double) {
        self.topLeft = topLeft
        self.height = height
        self.width = width
    }
    
    public func area() -> Double {
        return height * width;
    }
}


/*
 Visitor pattern
 In object-oriented programming and software engineering, the visitor design pattern is a way of separating an algorithm from an object structure on which it operates. A practical result of this separation is the ability to add new operations to existing object structures without modifying the structures.
 */








/* Question: In Parking area there are different vechicles are there. Like. Car, Motorbike, Lorry, Bus
 
 its like Array of vechicles. I want to know Service charge for each individual from vechicle.
 So, if it is a Car. Then the service charge will be 100
 and, if it is Motorbike. Then the service charge will be 50
 and, if it is Lorry. then the service charge will be 150
 and, if it is Bus. then the service charge will be 120
 
 How to design this?
    Need to know which vechicle charged how much service fee?
*/

protocol VechicleProto {
    func serviceCharge() -> Int
}

enum VechicleType {
    case car
    case motorbike
    case lorry
    case bus
}

class Vechicle: VechicleProto {
    
   static func makeVechicle(type: VechicleType) -> Vechicle {
        switch(type) {
        case .car: return Car()
        case .motorbike: return Motorbike()
        case .lorry: return Lorry()
        case .bus: return Bus()
        }
    }
    
    func serviceCharge() -> Int {
        fatalError("Call happen via child")
    }
    
}


class Car: Vechicle,VechicleProtoo {
    //We can do some customisation and al.
    override func serviceCharge() -> Int {
        return 100
    }
}

class Motorbike: Vechicle,VechicleProtoo {
    
    override func serviceCharge() -> Int {
        return 50
    }
}

class Lorry: Vechicle,VechicleProtoo {
    
    override func serviceCharge() -> Int {
        return 150
    }
}

class Bus: Vechicle,VechicleProtoo {
    
    override func serviceCharge() -> Int {
        return 120
    }
}

//NEW WAY:<VISITOR PATTERN>

protocol VechicleProtoo {
    func accept(vehicleInspector: VechicleInspectorProto) -> Int
}

protocol VechicleInspectorProto {
    /* A vehicle Inspector is supposed to visit all the vehicles parked in his shop and calculate the cost
      for each one of them. */
    func visit(car: Car) -> Int
    func visit(lorry: Lorry) -> Int
    func visit(motorbike: Motorbike) -> Int
    func visit(bus: Bus) -> Int
}

extension Car {
    func accept(vehicleInspector: VechicleInspectorProto) -> Int {
        return vehicleInspector.visit(car: self)
    }
}

extension Motorbike {
    func accept(vehicleInspector: VechicleInspectorProto) -> Int {
        return vehicleInspector.visit(motorbike: self)
    }
}

extension Lorry {
    func accept(vehicleInspector: VechicleInspectorProto) -> Int {
        return vehicleInspector.visit(lorry: self)
    }
}

extension Bus {
    func accept(vehicleInspector: VechicleInspectorProto) -> Int {
        return vehicleInspector.visit(bus: self)
    }
}


class VechicleInspection: VechicleInspectorProto {
    
    func visit(car: Car) -> Int {
        return 100
    }
    
    func visit(lorry: Lorry) -> Int {
        return 150
    }
    
    func visit(motorbike: Motorbike) -> Int {
        return 50
    }
    
    func visit(bus: Bus) -> Int {
        return 120
    }
}
