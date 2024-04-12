import Foundation

// Classes are reference types. they can mutate values internally without needing the mutating keyword
// constructors are required for classes

// classes can inherit from each other - subclassing

// classes can have Convenience initializers and Designated initializers
// classes can have multiple Convenience initializers and multiple Designated initializers

class Person {
    let name: String
    var age: Int

    init(name: String, age: Int, notClassProperty: Int? = 0) {
        self.name = name
        self.age = age
        // notClassProperty can be used here to for other calculations or something
    }

    func birthday() {
        self.age += 1
    }
}

// classes allow internal mutability. note the let keyword

let person1 = Person(name: "Hank", age: 81)
person1.birthday()
person1.age

// reference types point to the same memory address and are not copied over

let person1Clone = person1
person1Clone.birthday()
person1Clone.age
person1.age

// instance equality (===) checks if the operands are pointed to the same memory space

person1Clone === person1

let person2 = Person(name: "Shank", age: 72)

person2 === person1Clone

// equality (==) checks if the operands (classes) are equal based on some logic
// you have to manually create it (==) to use it

class Animal: Equatable {
    var name: String
    var age: Int
    var specie: String

    init(name: String, age: Int, specie: String) {
        self.name = name
        self.age = age
        self.specie = specie
    }

    static func == (lhs: Animal, rhs: Animal) -> Bool {
        lhs.specie == rhs.specie
    }
}

let animal1 = Animal(name: "Jansawed", age: 4, specie: "Homo Erectus")
let animal2 = Animal(name: "Loswad", age: 17, specie: "Homo Erectus")

animal1 == animal2
animal1 === animal2

// Subclassing

class Vehicle {
    func goBrrrr() -> String {
        "Brrrrrrr Brrrrrrrrgh!"
    }
}

class Car: Vehicle {}

let newCar = Car()
newCar.goBrrrr()

// by default, class properties can be both internally & externally changed
// lets make it changeable only internally

class AnotherPerson {
    var name: String
    private(set) var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    func birthday() {
        self.age += 1
    }
}

let anotherPerson = AnotherPerson(name: "Hans", age: 56)
// anotherPerson.age += 1
anotherPerson.birthday()
anotherPerson.age

// there are Convenience and Designated initializers
// convenience initializers can call designated initializers in thier class and superclasses
// convenience initializers can call convenience initializers in thier class and superclasses

// designated initializers can only call designated initializers in thier superclasses

class Pet {
    var name: String
    var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    convenience init(name: String) {
        self.init(name: name, age: 0)
    }
}

class FurryPet: Pet {
    convenience init() {
        self.init(name: "Noname")
    }

    init(name: String) {
        super.init(name: name, age: 1)
    }
}

let fpet1 = FurryPet()
fpet1.name
fpet1.age

let fpet2 = FurryPet(name: "Jagu")
fpet2.name
fpet2.age

// de-initializers are run by Swift when removing classes from memory

class Random {
    init() {
        "Initialized"
    }

    func doSomething() {
        "Did something"
    }

    deinit {
        "Deinitialized"
    }
}

let myClosure = {
    let randy = Random()
    randy.doSomething()
}

myClosure()
