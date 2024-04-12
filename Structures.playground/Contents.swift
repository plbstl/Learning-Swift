import Foundation

// constructors are implicitly created by the compiler
// but only in structures, and not in classes

// structs cannot inherit from structs, but can conform to protocols

// structures are value types

// maybe think of structs as object notation in javascript? but that they are value types, not reference types

// Structs do not have convenience initializers

struct Pet {
    var name: String
    var age: Int
}

let pet1 = Pet(name: "Terror", age: 13)
pet1.name
pet1.age

// sometimes constructors/initializers are necessary

struct CommodoreComputer {
    let name: String
    let manufacturer: String

    init(name: String) {
        self.name = name
        self.manufacturer = "Commodore"
    }
}

let c64 = CommodoreComputer(name: "My Sunshine")
let c128 = CommodoreComputer(name: "My Only Sunshine")

// alternative way to initialize properties

struct AppleComputer {
    let name: String
    let manufacturer = "Apple Inc"
}

let m1 = AppleComputer(name: "Macbook Air")

// OR

struct AcerComputer {
    let name: String
    let manufacturer = "Acer Corp"

    init(name: String) {
        self.name = name
    }
}

let aspire = AcerComputer(name: "Aspire Series 1E")

// Computed Properties

struct Person {
    let firstName: String
    let lastName: String
    let fullName: String

    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = "\(firstName) \(lastName)"
    }
}

let person1 = Person(firstName: "Jasper", lastName: "Jinga")

struct BetterPerson {
    let firstName: String
    let lastName: String
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}

let person2 = BetterPerson(firstName: "Jacinta", lastName: "Joseph")
person2.fullName
// fullName computer property doesn't show up
person2.self

// mutating Structures

struct Car {
    var currentSpped: Int
    mutating func drive(speed: Int) {
        currentSpped = speed
    }
}

let immutableCar = Car(currentSpped: 3)
// immutableCar.drive(speed: 8)

var mutableCar = Car(currentSpped: 2)
mutableCar.drive(speed: 17)

let copiedMutableCar = mutableCar
// copiedMutableCar.drive(speed: 12)

// Recipe: Changing values while copying

struct Bike {
    let manufacturer: String
    let currentSpeed: Int

    func copy(currentSpeed: Int) -> Bike {
        Bike(manufacturer: manufacturer, currentSpeed: currentSpeed)
    }
}

let bike1 = Bike(manufacturer: "Harley Davison", currentSpeed: 45)
let bike2 = bike1.copy(currentSpeed: 23)

bike1.currentSpeed
bike2.currentSpeed
