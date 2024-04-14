import Foundation

// MARK: - Person

// Error - failure of the code we've written
// Exception - failure of the person calling our functions

// Errors can be thrown anywhere; classes, constructors, functions, structures

struct Person {
  enum Errors: Error {
    case firstNameIsNil
    case lastNameIsNil
    case bothNamesAreNil
  }

  var firstName: String?
  var lastName: String?

  func getFullName() throws -> String {
    // pattern matching
    switch (firstName, lastName) {
      case (.none, .none):
        throw Errors.bothNamesAreNil

      case (.none, .some):
        throw Errors.firstNameIsNil

      case (.some, .none):
        throw Errors.lastNameIsNil

      case let (.some(firstName), .some(lastName)):
        return "\(firstName) \(lastName)"
    }
  }
}

// there is a global error variable named `error` which contains the error

do {
  let p = Person()
  try p.getFullName()
} catch {
  "Got an error: \(error)"
}

// you can rename global error variable

do {
  let p = Person(lastName: "Zodylck")
  try p.getFullName()
} catch let renameGlobalErrorVar {
  "Got an error: \(renameGlobalErrorVar)"
}

// this doesn't throw, so catch isn't executed

do {
  let p = Person(firstName: "Kilua", lastName: "Zodylck")
  try p.getFullName()
} catch {
  "Got an error: \(error)"
}

// catch specific errors

// check if it throws a Person.Errors error
// catching an error of a specific type

do {
  let p = Person(firstName: "Kilua")
  try p.getFullName()
  // more code
  // more try ...
} catch is Person.Errors {
  // no more access to the error variable
  "Got an error."
} catch {
  // can still add more catch blocks
  "Some other error was thrown \(error)"
}

// check if it throws a specific Person.Error error
// catching a specific error

do {
  let p = Person()
  try p.getFullName()
} catch Person.Errors.firstNameIsNil {
  "first Name Is Nil Person Error"
} catch Person.Errors.lastNameIsNil {
  "last Name Is Nil Person Error"
} catch Person.Errors.bothNamesAreNil {
  "both Names Are Nil Person Error"
} catch {
  // can still add more catch blocks
  "Some other error was thrown \(error)"
}

// validate initializers

struct Car {
  var manufacturer: String

  enum Errors: Error {
    case invalidManufacturer
  }

  init(manufacturer: String) throws {
    if manufacturer.isEmpty {
      throw Errors.invalidManufacturer
    }
    self.manufacturer = manufacturer
  }
}

do {
  let car = try Car(manufacturer: "")
  car.manufacturer
} catch Car.Errors.invalidManufacturer {
  "Invalid Manufacturer"
} catch {
  "Some other error: \(error)"
}

// another way if i don't care about the error thrown, or don't need the catch block

// optionally try to call this function, and if it's successful, give me the return value

if let myCar = try? Car(manufacturer: "Telsa") {
  // myCar is only available in this scope, as expected
  "It works! My car has been created. \(myCar)"
} else {
  // i don't need this else block, but i'm sure it's good practice to have one
  "An error occured. I cannot access the error thrown. I most likely don't care about error in the first place, that's why I'm using this syntax"
}

// you can assert dominance and force unwrap with (!)

let theCar = try! Car(manufacturer: "Beast") // the app/playground will crash if this fails, because no failsafe
theCar.manufacturer

// a function can throw any error. obviously errors that are available in its scope

struct Dog {
  let isInjured: Bool
  let isSleeping: Bool

  enum BarkingErros: Error {
    case cannotBarkIsSleeping
  }

  enum RunningErrors: Error {
    case cannotRunIsInjured
  }

  func bark() throws {
    if isSleeping {
      throw BarkingErros.cannotBarkIsSleeping
    }
    "Barking..."
  }

  func run() throws {
    if isInjured {
      throw RunningErrors.cannotRunIsInjured
    }
    "Running..."
  }

  func barkAndRun() throws {
    // functions that can throw don't need to handle errors
    // try is used nakedly
    try bark()
    try run()
  }
}

let dog = Dog(isInjured: true, isSleeping: true)

// you cannot catch multiple errors in the same do statement

do {
  try dog.barkAndRun()
  // the first error thrown will be the only error, because executed will step out
} catch Dog.BarkingErros.cannotBarkIsSleeping {
  "Damn! The dog cannot bark"
} catch Dog.RunningErrors.cannotRunIsInjured {
  "Damn! The dog cannot run"
} catch {
  "An error occured: \(error)"
}

// rethrowing errors
// functions that rethrow has to have a parameter of a function/closure that throws
// basically means it has to receive a function that can throw (eg. calculator param)

func fullName(
  firstName: String?,
  lastName: String?,
  calculator: (String?, String?) throws -> String?
) rethrows
  -> String?
{
  try calculator(firstName, lastName)
}

enum NameErros: Error {
  case firstNameIsInvalid
  case lastNameIsInvalid
}

// This function doesn't return an optional but still works with the optional string function signature

func + (firstname: String?, lastName: String?) throws -> String {
  guard let firstname, !firstname.isEmpty else {
    throw NameErros.firstNameIsInvalid
  }

  guard let lastName, !lastName.isEmpty else {
    throw NameErros.lastNameIsInvalid
  }

  return "\(firstname) \(lastName)"
}

if let fullname = try? fullName(firstName: "Gunther", lastName: "Quil", calculator: +) {
  fullname
} else {
  "do nothing"
}

do {
  let fullname = try fullName(firstName: "Peter", lastName: "", calculator: +)
} catch NameErros.firstNameIsInvalid {
  "invalid first name"
} catch NameErros.lastNameIsInvalid {
  "invalid last name"
} catch let err {
  "An error occured: \(err)"
}

// show that an error/exception is graceful
// use the Result type to show either a success or a failure. Result<Success, Error>

enum IntegerErrors: Error {
  case noPositiveIntegerBefore(thisValue: Int)
}

func getPreviousPositiveInteger(from int: Int) -> Result<Int, IntegerErrors> {
  guard int > 0 else {
    return Result.failure(
      IntegerErrors.noPositiveIntegerBefore(thisValue: int)
    )
  }
  return Result.success(int - 1)
}

// create more complexity - wahala

func performGet(forvalue value: Int) {
  // Result is an enum just like Optional, you can perform switch
  switch getPreviousPositiveInteger(from: value) {
    case let .success(previousValue):
      "Previous value is: \(previousValue)"

    case let .failure(error):
      switch error {
        case let .noPositiveIntegerBefore(thisValue):
          "There are no positive integers before: \(thisValue)"
      }
  }
}

performGet(forvalue: -1)
performGet(forvalue: 3)
