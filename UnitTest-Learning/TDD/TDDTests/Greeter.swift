//
//  Greeter.swift
//  TDDTests
//
//  Created by BKS-GGS on 07/04/21.
//

import Foundation

struct Greeter {
    
    init(name: String) {
        
    }
    
    private func hour(for time: Date) -> Int {
        let components = Calendar.current.dateComponents([.hour], from: time)
        return components.hour ?? 0
    }
    
    func greet(time: Date) -> String {
        let theHour = hour(for: time)
//        if theHour == 12 || theHour == 16 || theHour == 14 {
        //I never used this.. So beautiful
        if 12 <= theHour && theHour <= 16 {
            return "Good afternoon."
        }
        if 0 <= theHour && theHour <= 4 || 17 <= theHour && theHour <= 23 {
            return "Good evening."
        }
        return "Good morning."
    }
}
