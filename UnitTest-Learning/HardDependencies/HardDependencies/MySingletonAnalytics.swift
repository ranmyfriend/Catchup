//
//  MySingletonAnalytics.swift
//  HardDependencies
//
//  Created by Ranjit on 16/03/21.
//

import Foundation

class MySingletonAnalytics {
    private static let instance = MySingletonAnalytics()
    
    //Adding backdoor to the Singleton
    //What it does, it actually going to have one instance for testing purpose. This is completely optional one. you can setup during starting up the testing. And cleaning up during teardown. This is the way of testing out the SINGLETON pattern in Unit Testing. So, it does not affect any production code and al.
    //In General you should avoid of mixing Testing code with production. Better introduce with Dependency Injenction pattern to solve this elegantly!
    //NOTE: But when you are going with Dependency Injection there is a lot of code changes involved. Thats why when we follow the subclassing and overriding methods we can change the complete functionality.
    #if DEBUG
    static var stubbedInstance: MySingletonAnalytics?
    #endif
    static var shared: MySingletonAnalytics {
        #if DEBUG
        if let stubbedInstance = stubbedInstance {
            return stubbedInstance
        }
        #endif
        return instance
    }
    
    func track(event: String) {
        Analytics.shared.track(event: event)
        
        if self !== MySingletonAnalytics.instance {
            print(">> Not the MySingletonAnalytics singleton")
        }
    }
}
