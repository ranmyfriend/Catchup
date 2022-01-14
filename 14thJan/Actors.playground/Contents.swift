import UIKit

//Topic: Actors Introduction in Swift
//Link: https://www.youtube.com/watch?v=5LKbL-I-CYY

class User {
    let id: String
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

/*
 another way of around creating a PRIVATE QUEUE to save the user in seprate thread in concurrent way. This same approach in better way we can achieve it via ACTORS in Swift
class UserStorage {
    private var store = [String: User]()
    //this private queue helps us to do the job of saving the user in the seperate thread.
    //queue.sync -> ordered way of processing the tasks one by one
    //queue.async -> unordered way of processing the tasks one by one
    private let queue = DispatchQueue(label: "user_save_queue")
    
    func get(_ id: String) -> User? {
        queue.sync {
            return self.store[id]
        }
    }
    
    func save(_ user: User) {
        queue.sync {
            self.store[user.id] = user
        }
    }
}
*/

//Here the actor will do all functions in synchronise by default.
actor UserStorage {
    private var store = [String: User]()
    
    
    func get(_ id: String) -> User? {
        return self.store[id]
    }
    
    func save(_ user: User) {
        self.store[user.id] = user
    }
    
    init() { }
}

/*
 When you wan to use Actor, the you have to call it in a Task block. It helps to avoid the race condition and concurrent
 Actor: Mainly works with Asynchrnous job to perform astheticaly
 */
let storage = UserStorage()
Task {
    let user = User(id: "123", name: "Jobs")
    await storage.save(user)
    let get = await storage.get("123")
    print(String(describing: get))
}
