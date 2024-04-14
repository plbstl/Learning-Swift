import Foundation

// MARK: - Pet

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

// MARK: - CommodoreComputer

// sometimes constructors/initializers are necessary

struct CommodoreComputer {
  // MARK: Lifecycle

  init(name: String) {
    self.name = name
    manufacturer = "Commodore"
  }

  // MARK: Internal

  let name: String
  let manufacturer: String
}

let c64 = CommodoreComputer(name: "My Sunshine")
let c128 = CommodoreComputer(name: "My Only Sunshine")

// MARK: - AppleComputer

// alternative way to initialize properties

struct AppleComputer {
  let name: String
  let manufacturer = "Apple Inc"
}

let m1 = AppleComputer(name: "Macbook Air")

// MARK: - AcerComputer

// OR

struct AcerComputer {
  // MARK: Lifecycle

  init(name: String) {
    self.name = name
  }

  // MARK: Internal

  let name: String
  let manufacturer = "Acer Corp"
}

let aspire = AcerComputer(name: "Aspire Series 1E")

// MARK: - Person

// Computed Properties

struct Person {
  // MARK: Lifecycle

  init(firstName: String, lastName: String) {
    self.firstName = firstName
    self.lastName = lastName
    fullName = "\(firstName) \(lastName)"
  }

  // MARK: Internal

  let firstName: String
  let lastName: String
  let fullName: String
}

let person1 = Person(firstName: "Jasper", lastName: "Jinga")

// MARK: - BetterPerson

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

// MARK: - Car

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

// MARK: - Bike

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
