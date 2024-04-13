import Foundation

// `if let value {}` unwraps an Optional

// Optionals mean it can have a value or lack thereof (nil)
// Optional is an instance of an enum (enumeration)

// EXAMPLES

// set to nil

func multiplyByTwo(_ value: Int? = nil) -> Int {
    if let value {
        value * 2
    } else {
        0
    }
}

multiplyByTwo()
multiplyByTwo(nil)
multiplyByTwo(4)

// force unwrap

func minusOne(_ value: Int? = 0) -> Int {
    value! - 1
}

minusOne()
// minusOne(nil) // execution error
minusOne(4)

// use default value in parameter

func minusTwo(_ value: Int = 0) -> Int {
    value - 2
}

minusTwo()
// minusTwo(nil)  // incompactible arg type
minusTwo(4)

// use default in function block 1

func plusOne(_ value: Int? = nil) -> Int {
    (value ?? 0) + 1
}

plusOne()
plusOne(nil)
plusOne(4)

// use default in function block 2

func plusTwo(_ value: Int? = nil) -> Int {
    let val = value ?? 0
    return val + 2
}

plusTwo()
plusTwo(nil)
plusTwo(4)

// compare nil

/// using `let` here will cause an error, because it isn't initialized
///
/// use this instead
///
/// ```swift
/// let age: Int?  =  nil
/// ```
var age: Int? = 9

if age != nil {
    "There is a value in AGE"
} else {
    "AGE is nil. No value detected"
}

// unwrap

if let age {
    "Inputted age is \(age)"
} else {
    "age is empty"
}

// you do not need to unwrap to compare against a value, see later part for more info ..155

if age == 0 {
    "if age is zero, this will run regardless"
} else {
    "age might be nil, or another integer value"
}

// guard

// guard is like the opposite of if
// so whatever the condition, to know the true meaning, negate it
// e.g. guard age != nil, make sure age is equal to nil
// guard blocks must return

func checkAge() {
    guard age != nil else {
        "Age is nil here"
        return
    }
    "Age is not empty BUT is not unwrapped. It type is still optional. Guess you have to do that manually"
}

checkAge()

// i get the whole guard clause thing, but in Go & TypeScript...

func checkAgeEasy() {
    if age == nil {
        "age easy is nil"
        return
    }
    "Age easy has a value. Still not unwrapped though"
}

checkAgeEasy()

// guard unwrap

let anotherAge: Int? = 22
func checkAnotherAge() {
    guard let anotherAge else {
        "anotherAge is nil here"
        return
    }
    "anotherAge (\(anotherAge)) is unwrapped when using `guard let`."
}

checkAnotherAge()

// you can switch on optionals since they are enums

switch anotherAge {
    case .none:
        "Another age is nil none nada"

    case let .some(value):
        "There is value in this age. \(value)"
}

// just like enums, you can check for a specific case

if case let .some(value) = anotherAge {
    "Checking if there is a value in an optional. \(value)"
}

// you do not need to unwrap to compare against a value.

if anotherAge == 0 {
    "if anotherAge is zero, this will run regardless"
} else {
    "anotherAge might be nil, or another integer value"
}

// you may prefer this syntax, as `.some(0)` tells you that age is an Optional

if anotherAge == .some(0) {
    "if anotherAge is zero, this will run regardless"
} else {
    "anotherAge might be nil, or another integer value"
}

// Optional chaining

struct Person {
    var name: String
    var address: Address?

    struct Address {
        var streetNumber: Int?
        var streetName: String
        var countryName: String?
    }
}

let person1 = Person(name: "Jookwq")

person1.address?.streetNumber

if let person1StreetNumber = person1.address?.streetNumber {
    person1StreetNumber
} else {
    "person1 did not enter a street number. maybe didn't even enter an address"
}

// alternative syntax

if
    let person1Address = person1.address,
    let person1AddressStreetNumber = person1Address.streetNumber
{
    person1Address
    person1AddressStreetNumber
} else {
    "person1 did not enter a street number. maybe didn't even enter an address"
}

// comparing optionals

let barman: Person? = Person(
    name: "Bar",
    // if the address is commented out, the first if block still executes
    address: Person.Address(
        streetNumber: nil,
        streetName: "Quunixna"
    )
)

barman?.address?.streetNumber
barman?.address?.streetName

if barman?.name == "Bar", barman?.address?.streetNumber == nil {
    "Name's Bar and DOES NOT have a street number. May not even have an address"
} else if barman?.name == "Bar", (barman?.address?.streetNumber) != nil {
    "Name's Bar and has a street number AND an address"
} else {
    "IDK man's name, IDK man's addy"
}

// pattern matching

let baz: Person? = Person(
    name: "Baz",
    address: Person.Address(
        streetNumber: 2,
        streetName: "Bazz Jazz",
        countryName: "Bazznation Republik"
    )
)

// you can have `where` clauses in case statements when switching on optional or enum values

switch baz?.address?.countryName {
    case let .some(bazCountryName) where bazCountryName.starts(with: "Baz"):
        "I see that Baz is still in Baz's nation, \(bazCountryName)"

    case let .some(bazCountryName):
        "Baz isn't in the country anymore. He is in \(bazCountryName)"

    case .none:
        "Baz is countryless"
}

// decisions decisions, if let or guard let

func getFullName1(firstName: String, lastName: String?) -> String? {
    if let lastName {
        "\(firstName) \(lastName)"
    } else {
        nil
    }
}

func getFullName2(firstName: String, lastName: String?) -> String? {
    guard let lastName else {
        return nil
    }
    return "\(firstName) \(lastName)"
}
