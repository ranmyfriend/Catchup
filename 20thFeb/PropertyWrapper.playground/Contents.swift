import UIKit

var str = "Hello, playground"

//Concept: @propertyWrapper

//ForExample: If we want to persist user model into NSUserDefault. what we usually do here is. we grab the dictionary<it contains all of the property key,values> from model and store it as setObject into userdefault. when we need with help of key we can retrieve it.

struct User {
    let name: String
    
    typealias dictionary = [String: String]
    init(name: String) {
        self.name = name
    }
    init?(dictionary: dictionary) {
        guard let name = dictionary["name"]
        else { return nil }
        self.name = name
    }
    
    var dictionary: dictionary {
        ["name":name]
    }
    
}

let user = User(name: "Jobs")

extension UserDefaults {
    
    var user: User? {
        set {
            setValue(newValue?.dictionary, forKey: "user")
            synchronize()
        }
        get {
            guard let stored = value(forKey: "user") as? [String: String] else {
                return nil
            }
            return User(dictionary: stored)
        }
    }
    
}

UserDefaults.standard.user = user
let storedUser = UserDefaults.standard.user
dump(storedUser)


//How are we going to refactor this using @propertyWrapper. Let's see

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    var projectedValue: Self {
        return self
    }
    
    func delete() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

struct UserDefaultsConfig {
//    @UserDefault("has_seen_app_introduction", defaultValue: false)
    @UserDefault("user", defaultValue: false)
    static var hasSeenAppIntroduction: Bool
}


@propertyWrapper struct Capitalized {
    var wrappedValue: String {
        didSet { wrappedValue = wrappedValue.capitalized }
    }

    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.capitalized
    }
}

struct NewUser {
    @Capitalized var firstName: String
    @Capitalized var lastName: String
}

let newUser = NewUser(firstName: "ranjith", lastName: "kumar")
dump(newUser)


//This is how we can store and get values using NSUserDefault
@propertyWrapper struct PersonStored {
    var wrappedValue: Dictionary<String,String> {
        set {
            print("set:newValue:\(newValue)")
            UserDefaults.standard.set(newValue, forKey: "a")
        }
        get {
            let value = UserDefaults.standard.object(forKey: "a") as? Dictionary<String,String> ?? [:]
            print("get:value:\(value)")
            return value
        }
    }
    
    init(wrappedValue: Dictionary<String,String>) {
        self.wrappedValue = wrappedValue
    }
}


struct Person {
    let name: String
    @PersonStored var dictionary: Dictionary<String,String> = [:]
    
    init(name: String) {
        self.name = name
    }
    
    init?(dictionary: [String: String]) {
        self.dictionary = dictionary
        guard let name = dictionary["name"]
        else { return nil }
        self.name = name
    }
}

let person = Person(dictionary: ["name":"Jack"])
person?.dictionary
