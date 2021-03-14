//
//  CoveredClass.swift
//  Coverage
//
//  Created by Ranjit on 14/03/21.
//

import Foundation
import UIKit

class ​CoveredClass​ {
    
    private(set) var area: Int
    
    //Computed properties are just functions without arguments. Do test those.
    var width: Int {
        didSet {
            area = width * width
            let color: UIColor = redOrGreen(for: width)
            drawSquare(width: width, color: color)
        }
    }
    
    init() {
        area = 0
        width = 0
    }
    
    private func redOrGreen(for width: Int) -> UIColor {
        width % 2 == 0 ? .red : .green
    }
    
    private func drawSquare(width: Int, color: UIColor) {
        //..stmts
    }
    
    //“Covering a conditional takes two tests—one for when the condition is true, and one for when it’s false. (That’s not counting && and || operators.)”
    static func max(_ x: Int, _ y: Int) -> Int {
        if x < y {
            return y
        }
//        else { //This else condition leads to improper code coverage. so it does not reach to the function ending to return of something.
//            return x
//        }
        return x
    }
    
    //“When testing a loop, try to test what happens if the loop is executed zero times and also two times.”
    static func commaSeprated(from: Int, to: Int) -> String {
        var result = ""
        for i in from..<to {
            result += "\(i),"
        }
        result += "\(to)"
        return result
    }
    
}

