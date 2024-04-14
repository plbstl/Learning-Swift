import Foundation

// Sets contain only unique values, based on hash values and equality
// so basically, when checking uniqueness, check that the hashValue of the object is unique AND check that it is not equal to another

// .compactMap on a Set returns an Array, so always type the result back to a Set if need be

// using `as? Int` with `compactMap` turns booleans to 0s and 1s

// you can grab values from dictionaries using subscripting (maybe think of it like computed properties in JavaScript?)

// ARRAYs

let numbers = [1, 2, 3, 4, 5]
numbers.first
numbers.last
numbers.count
numbers.capacity
numbers.isEmpty
numbers.map(-) // ???

// loop through

for number in numbers {
  number
}

var mutatingNumbers = [1, 2, 3]
mutatingNumbers.capacity
mutatingNumbers.append(4)
mutatingNumbers.capacity
mutatingNumbers.insert(5, at: 4) // .at has to be in range, or an error occurs
mutatingNumbers.capacity
mutatingNumbers.insert(contentsOf: [8, 6, 7, 12], at: 1)
mutatingNumbers.capacity
mutatingNumbers.append(contentsOf: [0, 00, 010, 007])
mutatingNumbers.capacity

// even numbers
for mutatingNumber in mutatingNumbers where mutatingNumber % 2 == 0 {
  mutatingNumber
}

// map through

mutatingNumbers.map { mutatingNumber in
  mutatingNumber * 2
}

mutatingNumbers.map { $0 * 2 }

// mapping through can return any value. it has generic types
mutatingNumbers.map { mutatingNumber -> String in
  String(mutatingNumber)
}

// filter through

// odd numbers
mutatingNumbers.filter { mutatingNumber in
  mutatingNumber % 2 != 0
}

mutatingNumbers.filter { $0 % 2 != 0 }

// map and filter through
mutatingNumbers.compactMap { mutatingNumber in
  // transform values
  let transformedNumber = mutatingNumber * 3

  // then filter
  return transformedNumber % 2 == 0
    ? transformedNumber
    : nil
}

// remove nil values

let numbersWithNil: [Int?] = [1, 2, nil, 3]
numbersWithNil.count

// remember compactMap maps and filters. so filter will auto-remove nil values
// but using filter alone will not change its type, even though they both return the same value

let newNumbersWithoutNil = numbersWithNil.compactMap { $0 }

// not an optional anymore
newNumbersWithoutNil

// to have an array of different types. Heterogeneous

let stuff1 = [1, "string", nil, false] as [Any?]
let stuff2 = [1, "string", false] as [Any]

let stuff1a: [Any?] = [1, "string", nil, false]
let stuff2a: [Any] = [1, "string", false]

// SETs
// Sets contain only unique values, based on hash values and equality

let uniqueNumbers = Set([3, 1, 2, 1, 3, 2, 1, 1])
uniqueNumbers.count
uniqueNumbers.map(-)

// can contain nil values too

let someNumbers = Set([1, 4, nil, 2, 2, 3, nil])
someNumbers.count

let someNotNilNumbers = Set(someNumbers.compactMap { $0 })
someNotNilNumbers.count

// to have a set of different types. Heterogeneous

let randyOrton: Set<AnyHashable> = Set([1, true, "false", false, 4, "11", "RKO", true, 4, 10, "11"])
randyOrton.count

// retrieve specific type values from Heterogeneous arrays and sets

let stringsInStuff1 = stuff1.compactMap { $0 as? String }
stringsInStuff1.count

let intsInStuff1 = stuff1.compactMap { $0 as? Int }
intsInStuff1.count

// remember that .compactMap on a Set return an Array, so always type the result back to a Set if need be

let stringsInRandyOrton = Set(randyOrton.compactMap { $0 as? String })
stringsInRandyOrton.count

/// not predictable !!!
let intsInRandyOrton = Set(randyOrton.compactMap { $0 as? Int })
intsInRandyOrton.count

let boolsInRandyOrton = Set(randyOrton.compactMap { $0 as? Bool })
boolsInRandyOrton.count

// it looks like booleans are turned into 0 and 1

let test1: Set<AnyHashable> = Set([true, false, true, true])
test1.count

let intsInTest1 = test1.compactMap { $0 as? Int }
intsInTest1.count

// MARK: - Person

// Sets calculates its uniqueness using Hashable protocol
// Hashable protocol also includes Equality

struct Person: Hashable {
  let id: UUID
  let name: String
  let age: Int
}

let sameID = UUID()

let p1 = Person(id: sameID, name: "Wisdom", age: 41)
let p2 = Person(id: sameID, name: "Manny", age: 29)

let personSet1 = Set([p1, p2])
personSet1.count

// MARK: - Person1

// the Set should contain only one item, since they have the same id
// but remember, equality is needed to determine what should be unique about it
// Swift's default implementation is to take the Hashable properties and check their equality using their hashValues together
// in this case, UUID, String and Int are all Hashable.
// Swift is not just going to check only UUID then.
// if you want that to change, you can provide a custom logic for checking equality
// for our custom logic; if two or more people have the same id, then it's the same person

struct Person1: Hashable {
  let id: UUID
  let name: String
  let age: Int

  // since Hashable should also be Equatable, Swift will still check the equality of the objects
  // here, we implement our own custom logic for checking equality of the instances

  static func == (lhs: Self, rhs: Self) -> Bool {
    lhs.id == rhs.id
  }

  // When hashing, take only id into consideration

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    // hasher.combine(name)
  }
}

let pid = UUID()

let pp1 = Person1(id: pid, name: "Jiwq", age: 18)
let pp2 = Person1(id: pid, name: "Zaak", age: 80)

let ppSet1 = Set([pp1, pp2])
ppSet1.count

// cross-check the equality
if pp1 == pp2 {
  "Equal"
} else {
  "Not equal"
}

// DICTIONARY Dictionaries

let userApiInfo: [String: Any] = [
  "name": "Gon Kun",
  "age": 12,
  "address": [
    "streetName": "Forest Hills",
    "country": "Nearby Island",
  ],
]

// subscripting

userApiInfo["name"]
userApiInfo["age"]
userApiInfo["address"]
userApiInfo["notFound"]
// userApiInfo["address"]["streetName"] // won't work

// DO NOT do this
// but you can cast its type to make it work
(userApiInfo["address"] as! [String: String])["streetName"] // works

// exxtract keys, values

userApiInfo.keys
userApiInfo.values

// the playgroud view is unpredictable, so printing these instead

print("\nALL VALUES\n")
for (key, value) in userApiInfo {
  print("\(key): \(value)")
}

print("\nONLY INT VALUES\n")
for (key, value) in userApiInfo where value is Int {
  print("\(key): \(value)")
}

print("\nONLY INT VALUES WITH THEIR KEYS LONGER THAN TWO CHARACTERS\n")
for (key, value) in userApiInfo where value is Int && key.count > 2 {
  print("\(key): \(value)")
}
