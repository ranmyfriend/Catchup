import UIKit

//Teacher: https://github.com/olivaresf

var str = "Hello, playground"

/*
About Closure:

1. They are self contained blocks
2. First class citizens
3. Its a function without labels and some frustrations exceptions
4. Its called Anonymous functions
*/

//MAP Higher order function.
func transform(originalStrings: [String],
               closure: (String) -> String)  -> [String] {
    var transformedStrings = [String]()
    for originalString in originalStrings {
        transformedStrings.append(closure(originalString))
    }
    return transformedStrings
}

//Normal one:
let valuess = transform(originalStrings: ["ran","abc"],
                        closure: {
                            (given: String) in given.capitalized
                        })


print(valuess)

//The below one is trailing closure. So if you want to you can write your own function and pass it to this as parameter like @selector
//let values = transform(originalStrings: ["ran","abc"]) { (string) -> String in
//    return string.capitalized
//}

//This is Easy form negleting the local variable inside the closure.
let values = transform(originalStrings: ["ran","abc"]) { $0.capitalized }

print(values)

//Even we can think about instead of String type we can go with Element. This is Generics which apply introduced to handle generics in our program - This will do it later.


func captalizeString(string: String) -> String {
    string.capitalized
}

let values1 = transform(originalStrings: ["ran","abc"], closure: captalizeString(string:))

print(values)


//KeyPaths:
//A way to access the property let/var from Model(struct/class)
values.map(\.localizedCapitalized)

//Explore more....
