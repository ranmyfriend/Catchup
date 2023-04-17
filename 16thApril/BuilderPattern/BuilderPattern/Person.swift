struct Person {
    private let firstName: String
    private let lastName: String
    private let age: Int
    private let phone: Int
    private let address: String
    
    init(firstName: String, lastName: String, age: Int, phone: Int, address: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.phone = phone
        self.address = address
    }
}
