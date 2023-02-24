//
//  ViewController.swift
//  Lazy+Dictionaries+Nil+EnumWithRawRepresentable
//
//  Created by BKS-GGS on 23/02/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CONCEPT: 1
        let array = Array(0...100000)
        //It tries to load all the values on memory and do the computation
        let multiplesOfThree = array.map { $0 * 3}

        //It tries to load all the values on memory on run time, at the time of accessing it
        let multiplesOfThreeUsingLazy = array.lazy.map { $0 * 3}

        print(multiplesOfThree[3])
        print(multiplesOfThreeUsingLazy[3])
        
        
        // CONCEPT: 2
        //When we create a dictionary with nil value, it is considered as object. so it wont ignore the key.
        var dict:[String: Int?] = ["A": 1, "B": 3, "C": nil]
        
        print(dict.count) //3
        
        // Here when you are setting the value to nil, dictionary automatically the removing the key as well
        dict["4"] = nil
        
        print(dict.count)//4

        dict["A"] = nil

        print(dict.count)//2
        
        dict["D"] = Optional(5)
        
        print(dict.count)//3
        
        // CONCEPT: 3
        // 🗝The key point is so:
        
//        When your enum conforms to `RawRepresentable` protocol, the equality operator (=) is overloaded and it starts to compare raw values of cases instead of cases themselves.
        enum MyEnum: RawRepresentable, CaseIterable {
            case first
            case second
            
            init?(rawValue: Int) {
                self = Self.allCases.randomElement()!
            }
            
            var rawValue: Int { return 1 }
        }
        
        print(MyEnum.first == MyEnum.second)
        
        
        // CONCEPT: 4
        //Here x?=4 assogms to 4 to x, because x?=4 first checks whether the previous value of x was non-nil before theis new assignment, If the previous value was non nil the assignment will work.
        var x: Int? = 1
        x? = 4
        print(x)
        
        //Here y?=5 does not assign 5 to y, because the previous value of y was nil before this new assignment.
        var y: Int? = nil
        y? = 5
        print(y)

    }

   

   
}




