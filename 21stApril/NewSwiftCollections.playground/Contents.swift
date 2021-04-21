/// Here i am just working out of new collection types introduced by Apple


/// 1)Deque

/*
Deque (pronounced “deck”) works much like Array: it is an ordered, random-access, mutable, range-replaceable collection with integer indices.

The main benefit of Deque over Array is that it supports efficient insertions and removals at both ends.
 
 This will help us to insert and remove from both ends
 */

let colors: Deque = ["red", "black", "blue"]

colors.prepend("green") // appending in front
colors.append("orange") // appending in tail
// `colors` is now ["green", "red", "yellow", "blue", "orange"]

colors.popFirst() // "green"
colors.popLast() // "orange"
// `colors` is back to ["red", "yellow", "blue"]


colors[1] // "yellow"
colors[1] = "peach"
colors.insert(contentsOf: ["violet", "pink"], at: 1)
// `colors` is now ["red", "violet", "pink", "peach", "blue"]
colors.remove(at: 2) // "pink"
// `colors` is now ["red", "violet", "peach", "blue"]
colors.sort()
// `colors` is now ["blue", "peach", "red", "violet"]


/// 2)OrderedSet

/*
 OrderedSet is a powerful hybrid of an Array and a Set.

 We can create an ordered set with any element type that conforms to the Hashable protocol:
 */

let buildingMaterials: OrderedSet = ["straw", "sticks", "bricks"]

// ARRAY wise printing out the index and values
for i in 0 ..< buildingMaterials.count {
  print("Little piggie #\(i) built a house of \(buildingMaterials[i])")
}
// Little piggie #0 built a house of straw
// Little piggie #1 built a house of sticks
// Little piggie #2 built a house of bricks

// SET does not create duplicate values.
buildingMaterials.append("straw") // (inserted: false, index: 0)
buildingMaterials.contains("glass") // false
buildingMaterials.append("glass") // (inserted: true, index: 3)
// `buildingMaterials` is now ["straw", "sticks", "bricks", "glass"]



func buildHouses(_ houses: Array<String>)

buildHouses(buildingMaterials) // error
buildHouses(buildingMaterials.elements) // OK

func blowHousesDown<S: SetAlgebra>(_ houses: S) { ... }

blowHousesDown(buildingMaterials) // error: `OrderedSet<String>` does not conform to `SetAlgebra`
blowHousesDown(buildingMaterials.unordered) // OK


/// 3)OrderedDictionary

/*
 OrderedDictionary is a useful alternative to Dictionary when the order of elements is important or we need to be able to efficiently access elements at various positions within the collection.
 */

let responses: OrderedDictionary = [
  200: "OK",
  403: "Forbidden",
  404: "Not Found",
]


responses[200] // "OK"
responses[500] = "Internal Server Error"


for (code, phrase) in responses {
  print("\(code) (\(phrase))")
}
// 200 (OK)
// 403 (Forbidden)
// 404 (Not Found)
// 500 (Internal Server Error)



responses[0] // nil (key-based subscript)
responses.elements[0] // (200, "OK") (index-based subscript)



if let i = responses.index(forKey: 404) {
  responses.keys[i] // 404
  responses.values[i] // "Not Found"
  responses.remove(at: i + 1) // (500, "Internal Server Error")
}
// `responses` is now [200: "OK", 403: "Forbidden", 404: "Not Found"]

