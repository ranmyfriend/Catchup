import UIKit

/*
 Topic: Property Wrappers in Swift Language
 Youtube Link: https://www.youtube.com/watch?v=i6F8VEzCFlY
 
 */


/* Example 1
 Here we are going to give uppercase behaviour to the customerCode, whenever it set. always make sure this will be Uppercased
@propertyWrapper struct Upper {
    var wrappedValue: String {
        didSet {
            wrappedValue = wrappedValue.uppercased()
        }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.uppercased()
    }
}


struct Customer {
    @Upper var customerCode: String
    
    init(customerCode: String) {
        self.customerCode = customerCode
    }
}

var customer = Customer(customerCode: "abc")

print(customer.customerCode)

customer.customerCode = "xyz"

print(customer.customerCode)
 */


// Inspired from this post https://www.avanderle.com/swift/property-wrappers/
/* Example 2 When we set a bool value, and it automatically do the setter and getting using nsuserdefaults.
 */

extension Mirror {
    
    static func isOptionalAndNil<Value>(_ instance: Value) -> Bool {
        let mirror = Mirror(reflecting: instance)
        return mirror.displayStyle == .optional && mirror.children.first?.value == nil
    }
}

extension UserDefaults {
    func containsKey(_ key: String) -> Bool {
        self.object(forKey: key) != nil
    }
}

@propertyWrapper struct UserDefault<Value> {
    
    let key: String
    let defaultValue: Value
    let container: UserDefaults = .standard
    
    var wrappedValue: Value {
        
        get {
            container.object(forKey: key) as? Value ?? defaultValue
        }
        set {

            // if the type is optional and if it is nil
            if Mirror.isOptionalAndNil(newValue) {
                if container.containsKey(key) {
                    container.removeObject(forKey: key)
                }
            } else {
                container.set(newValue, forKey: key)
            }
        }
    }
}

struct Settings {
    @UserDefault(key: "isDarkMode", defaultValue: false) var isDarkMode: Bool?
}
 
var settings = Settings()
settings.isDarkMode = true
print(settings.isDarkMode)
settings.isDarkMode = nil
print(settings.isDarkMode)
