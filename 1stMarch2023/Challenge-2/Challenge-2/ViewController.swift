//
//  ViewController.swift
//  Challenge-2
//
//  Created by BKS-GGS on 03/03/23.
//

import UIKit

/*              Swift Tips          */

class A {
    func f(value: Int = 10) {
        print("A:\(value)")
    }
}

class B: A {
    override func f(value: Int = 100) {
        print("B:\(value)")
    }
}

class C: B {
    override func f(value: Int = 1000) {
        print("C:\(value)")
    }
}
//What will be the output?

class Car {
    
}

extension Car {
    //unless otherwise if you add @objc then only it will be added into vTable
    @objc func fuelCapacity() -> Double {
        fatalError()
    }
}

class Tata: Car {
     override func fuelCapacity() -> Double {
         return 0.0
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let c: A = C()
//        c.f()
        
        
    }


}

