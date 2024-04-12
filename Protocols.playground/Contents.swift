import Foundation

// maybe think of protocols as interfaces in typescript? but that they can also have implementations (like in Dart)

// protocols cannot be instantiated

protocol CanBreathe {
    func breathe()
}

struct Animal: CanBreathe {
    func breathe() {
        "Animal breathing..."
    }
}

struct Person: CanBreathe {
    func breathe() {
        "Person breathing..."
    }
}

let cat = Animal()
cat.breathe()
let dude = Person()
dude.breathe()

// protocol with (default) implementation
// maybe think of extensions as prototypes in javascript? [Object.proto.newMethod = () => {}]

protocol CanJump {
    func jump()
}

extension CanJump {
    func jump() {
        "Jumping..."
    }
}

struct Cat: CanJump {
    func jump() {
        "Can override default jump implementation"
    }
}

let whiskers = Cat()
whiskers.jump()

// protocols can also define variables, they have to have explicit read/write properties
// the thing is, these read/write properties ({get set}) are only enforced in Extensions
// you can write to a read-only property when using var & mutating keywords in a Struct

protocol HasNameAndAge {
    var name: String { get }
    var age: Int { get set }
    /// i did not put all the function headers/signatures in the protocol. it is possible to not do so
    /// i think it is best to put all function headers/signatures in the protocol. easier to understand at first glance
    mutating func birthday()
}

extension HasNameAndAge {
    func describe() -> String {
        "Your name is \(self.name), and you are \(self.age) years old"
    }

    /// understandable, because age is readable & writable
    mutating func birthday() {
        self.age += 1
    }

    // Cannot assign to property: 'name' is a get-only property. but can do that in the struct
    //    mutating func changeName() {
    //        self.name = "Shanta"
    //    }
}

struct Lady: HasNameAndAge {
    /// var means name can be mutated
    var name: String
    var age: Int

    /// should not be possible, even when using var?
    mutating func changeName() {
        self.name = "Shanta"
    }
}

var lady1 = Lady(name: "Jo", age: 26)
lady1.birthday()
lady1.describe()

lady1.name += " ss"
lady1.age += 2
lady1.name
lady1.age
lady1.describe()

lady1.changeName()
lady1.describe()

// is keyword checks if a struct conforms to a specific protocol
// as keyword checks if a struct conforms to a specific protocol, and promotes the struct

protocol Vehicle {
    var speed: Int { get set }
    mutating func accelerate(by value: Int)
}

extension Vehicle {
    mutating func accelerate(by value: Int) {
        self.speed += value
    }
}

struct Bike: Vehicle {
    var speed: Int = 0
}

var bike = Bike()
bike.speed
bike.accelerate(by: 23)
bike.speed

func describeRelationship(obj: Any) {
    if obj is Vehicle {
        // no code completion, obj is still of type Any
        "\(obj) conforms to Vehicle protocol"
    } else {
        "\(obj) DOES NOT conforms to Vehicle protocol"
    }
}

describeRelationship(obj: bike)

struct Randy {}
let rando = Randy()
describeRelationship(obj: rando)

func increaseSpeedIfVehicle(obj: Any) {
    if var vehicle = obj as? Vehicle {
        // code completion, vehicle is of type Vehicle
        vehicle.speed
        vehicle.accelerate(by: 15)
        vehicle.speed
    } else {
        "Not a vehicle"
    }
}

increaseSpeedIfVehicle(obj: bike)
increaseSpeedIfVehicle(obj: rando)

// note that bike speed doesn't change, because it is a struct. and the value is copied over
bike.speed

// if you want the function to mutate the bike's speed in this outer scope, use a class instead
