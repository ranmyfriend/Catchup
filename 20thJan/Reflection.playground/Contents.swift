import UIKit

// Topic: Swift: Reflection Introduction (Xcode 13, 2022) – iOS
// Link: https://www.youtube.com/watch?v=1GAXGwWdq8g

//class Resettable {
//
//    init() {
//
//    }
//    func reset() {
//        print("You reset a person")
//    }
//}


//struct Person {
//    let name: String
//    let resetter = Resettable()
//}


struct Measurements {
    let height: CGFloat
    let width: Float
    let weight: Int
    let depth: Int
}

extension Mirror {
    static func match<T>(
        for thing: Any,
        matching: T.Type = T.self,
        block: @escaping (T) -> Void
    ) {
        let reflection = Mirror(reflecting: thing)
        for child in reflection.children {
            if let match = child.value as? T {
                block(match)
            }
        }
    }
}

func go() {
    print("Started")
    
    let measurements = Measurements(height: 12.2, width: 32.1, weight: 101, depth: 7)
    
    Mirror.match(for: measurements, matching: Float.self) { match in
        print("Found: \(match)\n\n")
    }
  
//    let person = Person(name: "Jobs")
//    let r = Mirror(reflecting: person)
//
//    for child in r.children {
//        guard let resetter = child.value as? Resettable else {
//            continue
//        }
//        resetter.reset()
//    }
}

go()


