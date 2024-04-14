import Foundation

// MARK: - Person

// For a struct, all its stored properties must conform to Equatable.
// For an enum, all its associated values must conform to Equatable.
// (An enum without associated values has Equatable conformance even without the declaration.)

// The built-in Equatable documentation is very helpful. I should go read all the docs for previous types used.

struct Person: Equatable {
  var id: String
  var name: String
}

let p1 = Person(id: "1", name: "one piece")
let p2 = Person(id: "1", name: "two piece combo")

if p1 == p2 {
  "They are equal"
} else {
  "They are not equal"
}

// custom equality

extension Person {
  static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.id == rhs.id
  }
}

// MARK: - AnimalType

enum AnimalType: Equatable {
  case dog(breed: String) // string is Equatable
  case cat(breed: String)
}

// equal - same animal, same breed
let dog1 = AnimalType.dog(breed: "jusa")
let dog2 = AnimalType.dog(breed: "jusa")

if dog1 == dog2 {
  "They are equal"
} else {
  "They are not equal"
}

// not equal - same animal, different breed
let dog3 = AnimalType.dog(breed: "iqsa")
let dog4 = AnimalType.dog(breed: "jjsf")

if dog3 == dog4 {
  "They are equal"
} else {
  "They are not equal"
}

// not equal - different animal, same breed
let dog5 = AnimalType.dog(breed: "qqqq")
let cat1 = AnimalType.cat(breed: "qqqq")

if dog5 == cat1 {
  "They are equal"
} else {
  "They are not equal"
}

// not equal - different animal, different breed
let dog6 = AnimalType.dog(breed: "kfsf")
let cat2 = AnimalType.cat(breed: "ifwfaa")

if dog6 == cat2 {
  "They are equal"
} else {
  "They are not equal"
}

// MARK: - Animal

struct Animal {
  let name: String
  let type: AnimalType
}

// MARK: Equatable

// overwrite equating logic

extension Animal: Equatable {
  static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.type == rhs.type
  }
}

let a1 = Animal(name: "Neo", type: .dog(breed: "Hugo"))
let a2 = Animal(name: "Vim", type: .dog(breed: "Hugo"))

if a1 == a2 {
  "They are equal. Because of same breed"
} else {
  "They are not equal"
}

// MARK: - House

// Hashable

struct House: Hashable {
  let number: Int
  let numberOfBedrooms: Int
}

let house1 = House(number: 21, numberOfBedrooms: 7)
let house2 = House(number: 21, numberOfBedrooms: 7)
let house3 = House(number: 22, numberOfBedrooms: 7)
let house4 = House(number: 22, numberOfBedrooms: 8)
house1.hashValue
house2.hashValue
house3.hashValue
house4.hashValue

let houses = Set([house1, house2, house3, house4])
houses.count

// MARK: - NumberedHouse

// overwrite hashing logic

// houses of the same house is unique

struct NumberedHouse: Hashable {
  let number: Int
  let bedrooms: Int

  static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.number == rhs.number
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(number)
  }
}

let h1 = NumberedHouse(number: 21, bedrooms: 7)
let h2 = NumberedHouse(number: 21, bedrooms: 7)
let h3 = NumberedHouse(number: 22, bedrooms: 7)
let h4 = NumberedHouse(number: 22, bedrooms: 8)

h1.hashValue
h1.number.hashValue

h2.hashValue
h2.number.hashValue

h3.hashValue
h3.number.hashValue

h4.hashValue
h4.number.hashValue

let numberedHouses = Set([h1, h2, h3, h4])
numberedHouses.count
numberedHouses.first?.hashValue

// MARK: - CarPart

// default hashable enums

enum CarPart {
  case window
  case engine
  case tyre
}

let uniqueParts: Set<CarPart> = [.window, .tyre, .window, .engine, .window, .engine, .tyre]
uniqueParts.count

// MARK: - HouseType

// enums with associated values

enum HouseType: Hashable {
  case bigHouse(NumberedHouse)
  case smallHouse(NumberedHouse)
  case otherHouse
}

let houseTypes: Set<HouseType> = [
  .otherHouse,
  .otherHouse,
  .smallHouse(NumberedHouse(number: 2, bedrooms: 3)),
  .smallHouse(NumberedHouse(number: 2, bedrooms: 6)),
  .bigHouse(NumberedHouse(number: 2, bedrooms: 8)),
  .bigHouse(NumberedHouse(number: 11, bedrooms: 18)),
  .bigHouse(NumberedHouse(number: 1, bedrooms: 8)),
]

houseTypes.count
houseTypes
