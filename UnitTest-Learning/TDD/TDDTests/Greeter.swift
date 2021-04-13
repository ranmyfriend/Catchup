//
//  Greeter.swift
//  TDDTests
//
//  Created by BKS-GGS on 07/04/21.
//

import Foundation

struct Greeter {
    
    private let name: String
    
    //Lookup Table
    private let greetingTimes: [(from: Int, greeting: String)] = [
        (0, "Good evening"),
        (5, "Good morning"),
        (12, "Good afternoon"),
        (17, "Good evening"),
        (24, "SENTINEL")
    ]
    
    init(name: String) {
        self.name = name
    }
    
    private func hour(for time: Date) -> Int {
        let components = Calendar.current.dateComponents([.hour], from: time)
        return components.hour ?? 0
    }
    
    private func greeting(for time: Date) -> String {
        let theHour = hour(for: time)
        
        for(index, greetingTime) in greetingTimes.enumerated() {
            if greetingTime.from <= theHour && theHour < greetingTimes[index + 1].from {
                return greetingTime.greeting
            }
        }
        return ""
    }
    
    //When we checking the negative condition at first, which is awkward. lets flip and add
    func greet(time: Date) -> String {
        let hello = greeting(for: time)
        
        if name.isEmpty {
            return "\(hello)."
        } else {
            return "\(hello), \(name)."
        }
        
        /* OLD CODE
        if greetingTimes[0].from <= theHour && theHour < greetingTimes[1].from {
            return greetingTimes[0].greeting
        }
        if greetingTimes[1].from <= theHour && theHour < greetingTimes[2].from {
            return greetingTimes[1].greeting
        }
        // I never used this.. So beautiful
        if greetingTimes[2].from <= theHour && theHour < greetingTimes[3].from {
            return greetingTimes[2].greeting
        }
        // Removed nested if condition and split into two If condition
        if greetingTimes[3].from <= theHour && theHour < greetingTimes[4].from {
            return greetingTimes[3].greeting
        }
        // Refactoring this blind fold of returning the Good morning stmt,
//        return "Good morning."
        // if nothing matches simply we returning ""
        return ""
         */
    }
}
