//
//  Analytics.swift
//  HardDependencies
//
//  Created by Ranjit on 16/03/21.
//

import Foundation

//ADAPTER DESIGN PATTERN
/*
 Tip:
 “Any time you use a third-party framework, consider wrapping it in an Adapter. This will let you change or augment the underlying implementation without changing the call sites.”
 */

class Analytics {
    static let shared = Analytics()
    
    func track(event: String) {
        print(">> " + event)
        
        if self !== Analytics.shared {
            print(">> ...Not the Analytics singleton")
        }
    }
}
