class PersonBuilder {
    private var firstName: String = ""
    private var lastName: String = ""
    private var age: Int = 0
    private var phone: Int = 0
    private var address: String = ""
    
    func setFirstName(_ firstName: String) -> PersonBuilder {
        self.firstName = firstName
        return self
    }
    
    func setLastName(_ lastName: String) -> PersonBuilder {
        self.lastName = lastName
        return self
    }
    
    func setAge(_ age: Int) -> PersonBuilder {
        self.age = age
        return self
    }
    
    func setPhone(_ phone: Int) -> PersonBuilder {
        self.phone = phone
        return self
    }
    
    func setAddress(_ address: String) -> PersonBuilder {
        self.address = address
        return self
    }
    
    func build() -> Person {
        Person(firstName: firstName, lastName: lastName, age: age, phone: phone, address: address)
    }
}
