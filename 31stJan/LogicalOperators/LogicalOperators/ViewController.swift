//
//  ViewController.swift
//  LogicalOperators
//
//  Created by BKS-GGS on 31/01/22.
//

import UIKit


func alwaysReturnTrue() -> Bool {
    print("This the function that always returns true")
    return true
}

func alwaysReturnFalse() -> Bool {
    print("This the function that always returns false")
    return false
}

// && operator is short circuit evalution. when the first stmt failes then it conclude the if stmt is fails. because it does not even try to execute alwaysReturnTrue func
func run() {
//    if alwaysReturnFalse() && alwaysReturnTrue() {
//
//    }
    
//    let array = [1,2,3]
//    let index = 4
//
//    // App wont crash because the first condition failed.
//    if array.indices.contains(index) && array[index] > 0 {
//        print("Test passed")
//    } else {
//        print("Test didn't pass")
//    }
    
    
    // || operator also does the same thing like && operator. when the left side condtion gets true, then it does not execute the next condition stmts.
    if alwaysReturnTrue() || alwaysReturnFalse() {
        
    }
 }

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        run()
       
    }


}

