import Foundation

// maybe think of extensions as prototypes in javascript? [Object.proto.newMethod = () => {}]

// Extensions also lets you add initializers, properties and functions to existing objects and types

extension Int {
    func plusTwo() -> Int {
        self + 2
    }
}

let num = 8
num.plusTwo()

// lets say we want this, but we have no access to Person struct and the fullName property is missing, and no initializer with fullName only
// we can use Extensions for that

struct Person {
    let firstName: String
    let lastName: String
    private let fullName: String

    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = "\(firstName) \(lastName)"
    }

    init(fullName: String) {
        let components = fullName.components(separatedBy: " ")

        self.firstName = components.first ?? fullName
        self.lastName = components.last ?? fullName
        self.fullName = fullName
    }
}

let p1 = Person(fullName: "Harley Davison")
p1.firstName
p1.lastName

// This is what we're working with

struct Persona {
    let firstName: String
    let lastName: String

    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

// using extensions...

extension Persona {
    init(fullName: String) {
        let components = fullName.components(separatedBy: " ")

        self.init(
            firstName: components.first ?? fullName,
            lastName: components.last ?? fullName
        )
    }
}

let p2 = Persona(fullName: "Helwett Packett")
p2.firstName
p2.lastName

// Extensions also lets you add initializers, properties and functions to existing objects and types

// lets say we have no access to this code

protocol GoesVrooom {
    var vroomValue: String { get }
    func goVroom() -> String
}

struct Car {
    var manufacturer: String
    var model: String
}

let car1 = Car(manufacturer: "Tesla", model: "Y")
car1.self

// lets extend the car struct to conform to a specific protocol

extension GoesVrooom {
    func goVroom() -> String {
        "\(self.vroomValue) goes vrooom"
    }
}

extension Car: GoesVrooom {
    var vroomValue: String {
        "\(self.manufacturer) model \(self.model)"
    }
}

car1.goVroom()

// you can add new functionality to all objects that conform to a certain protocol

extension GoesVrooom {
    func goesVroomTimesTwo() -> String {
        "\(self.vroomValue) goes vroOom vRoOOMm"
    }
}

car1.goesVroomTimesTwo()

// adding a convenience init with extensions

class MyDouble {
    let value: Double
    init(value: Double) {
        self.value = value
    }
}

extension MyDouble {
    convenience init() {
        self.init(value: 0)
    }
}

let md1 = MyDouble()
md1.value
let md2 = MyDouble(value: 3)
md2.value
