import Foundation

// MARK: - Animal

// it is very neccessary to compare enums using switch statement. it is exhaustive which is extremely helpful when refactoring

// enums with associative values have no implicit comparison operators. you have to create them manually

enum Animal {
  case cat
  case dog
  case rabbit
  case snake
  case hare
}

let animal1 = Animal.hare

if animal1 == Animal.cat {
  "Meeooww"
} else if animal1 == Animal.snake {
  "Hisssss"
} else if animal1 == Animal.dog {
  "Woooff"
} else {
  "Dances*"
}

// using Switch statement

switch animal1 {
  case .cat:
    "Meeooww"
  case .dog:
    "Woooff"
  case .rabbit:
    "Rfsfgsc"
  case .snake:
    "HissSss"
  case .hare:
    "Rrhhhh"
}

// MARK: - Shortcut

// Associative Enums

enum Shortcut {
  case file(dirPath: URL, fileName: String)
  case wwwURL(path: URL)
  case song(artist: String, songName: String)
}

let configFile = Shortcut.file(dirPath: URL(string: "/Users/iamhim")!, fileName: "main.config")
let appleCom = Shortcut.wwwURL(path: URL(string: "https://apple.com")!)
let ringtone = Shortcut.song(artist: "System", songName: "Classic")

switch configFile {
  case let .file(dirPath: path, fileName: name):
    // args can be renamed
    break
  case let .wwwURL(path: path):
    break
  case let .song(artist: artist, songName: songName):
    break
}

// this is how it is usually written. much cleaner
switch appleCom {
  case let .file(dirPath, fileName):
    break
  case let .wwwURL(p):
    // you can also change the arg names but not suggested, as it will mosdef hinder later on
    break
  case let .song(artist, songName):
    break
}

// actually, this is much cleaner
switch ringtone {
  case let .file(dirPath, fileName):
    break
  case let .wwwURL(path):
    break
  case let .song(owner, name):
    // you can also change the arg names but not suggested, as it will mosdef hinder later on
    break
}

// if you need to check for just specific enum case with if statement
if case let .file(dirPath, fileName) = configFile {
  fileName
}

// OR

if case let .wwwURL(path) = appleCom {
  path
}

if case let .song(_, songName) = ringtone {
  songName
}

// ignore args
if case let .song(_, songName) = ringtone {
  songName
}

// MARK: - Vehicle

// pattern matching types for enums

enum Vehicle {
  case car(manufacturer: String, model: String)
  case bike(manufacturer: String, year: Int)
  case test(Int, String)
}

let telsaX = Vehicle.car(manufacturer: "Telsa", model: "X")
let harley87 = Vehicle.bike(manufacturer: "HD", year: 1987)

// so i want to get manufacturer from vehicles easily

func getManufacturer(from vehicle: Vehicle) -> String {
  switch vehicle {
    case let .car(manufacturer, _):
      manufacturer
    case let .bike(manufacturer, _):
      manufacturer
    case let .test(_, manufacturer):
      manufacturer
  }
}

getManufacturer(from: telsaX)
getManufacturer(from: harley87)

// MARK: - Vehicle2

// we can move the getManufacturer() to inside the enum

enum Vehicle2 {
  case car(manufacturer: String, model: String)
  case bike(manufacturer: String, year: Int)

  // MARK: Internal

  func getManufacturer() -> String {
    switch self {
      case let .car(manufacturer, _):
        manufacturer
      case let .bike(manufacturer, _):
        manufacturer
    }
  }
}

let telsaY = Vehicle2.car(manufacturer: "Telsa", model: "Y")
let harley97 = Vehicle2.bike(manufacturer: "HD", year: 1997)

telsaY.getManufacturer()
harley97.getManufacturer()

// MARK: - Vehicle3

// we can turn getManufacturer() to a computed property

enum Vehicle3 {
  case car(manufacturer: String, model: String)
  case bike(manufacturer: String, year: Int)
  case test(Int, String)

  // MARK: Internal

  var manufacturer: String {
    switch self {
      case let .car(manufacturer, _):
        manufacturer
      case let .bike(manufacturer, _):
        manufacturer
      case let .test(_, manufacturer):
        manufacturer
    }
  }
}

let telsaS = Vehicle3.car(manufacturer: "Telsa", model: "S")
let suzuki07 = Vehicle3.bike(manufacturer: "Suzuki", year: 2007)

telsaS.manufacturer
suzuki07.manufacturer

// MARK: - Vehicle4

// clean up the manufacturer computed property

enum Vehicle4 {
  case car(manufacturer: String, model: String)
  case bike(manufacturer: String, year: Int)

  // MARK: Internal

  var manufacturer: String {
    switch self {
      case let .bike(manufacturer, _), let .car(manufacturer, _):
        manufacturer
    }
  }
}

let mecerdesBenz = Vehicle4.car(manufacturer: "Mercedes", model: "Benz")
let suzuki99 = Vehicle4.bike(manufacturer: "Suzuki", year: 1999)

mecerdesBenz.manufacturer
suzuki99.manufacturer

// MARK: - Vehicle5

// it doesn't have to be the same param location, or the same initial name, it has to be the same TYPE

enum Vehicle5 {
  case car(manufacturer: String, model: String)
  case bike(manufacturer: String, year: Int)

  // MARK: Internal

  var manufacturer: String {
    switch self {
      // param is on the right. same TYPE too
      case let .car(_, sameRandomName):
        sameRandomName
      // param is on the left. same TYPE too
      case let .bike(sameRandomName, _):
        sameRandomName
    }
  }
}

let bmwX7 = Vehicle5.car(manufacturer: "BMW", model: "X7")
let suzuki89 = Vehicle5.bike(manufacturer: "Suzuki", year: 1989)

// will print out wrong info. but this is a demo example for using different params of the same type for pattern matching enums
bmwX7.manufacturer
suzuki89.manufacturer

// MARK: - FamilyMember

// raw values

enum FamilyMember: String {
  case father = "Dad"
  case mother = "Mom"
  case brother = "Bro"
  case sister = "Sis"
}

FamilyMember.brother
FamilyMember.brother.rawValue

// MARK: - FavoriteEmoji

// access all enum cases at once

enum FavoriteEmoji: String, CaseIterable {
  case eyes = "👀"
  case bird = "🐦"
  case footprint = "👣"
  case scroll = "📜"
  case droplet = "💧"
  case memo = "📝"
  case rock = "🪨"
  case spider = "🕷️"
  case beetle = "🪲"
  case fire = "🔥"
  case warning = "⚠️"
}

FavoriteEmoji.allCases

FavoriteEmoji.allCases.map { favEmoji in
  print(favEmoji)
}

FavoriteEmoji.allCases.map(\.rawValue)

// create enum case from raw value

if let newVar = FavoriteEmoji(rawValue: "👀") {
  // newVar is only available in scope
  "eyes emoji is a favorite"
  newVar
} else {
  "doesn't have eyes emoji as a favorite"
}

if let snow = FavoriteEmoji(rawValue: "❄️") {
  // snow is only available in scope
  "snow emoji is a favorite"
  snow
} else {
  "doesn't have snow emoji as a favorite"
}

// MARK: - Size

// Mutating members of enumerations

enum Size {
  case small, medium, large

  // MARK: Internal

  mutating func makeLarge() {
    self = Size.large
  }
}

var shirt = Size.medium
shirt

shirt.makeLarge()

// MARK: - IntOperation

// Indirect/Recursive Enumerations
// hardly ever used

indirect enum IntOperation {
  case add(Int, Int)
  case subtract(lhs: Int, rhs: Int)
  case divide(numerator: Int, denominator: Int)
  case multiply(Int, Int)
  case freeHand(IntOperation)

  // MARK: Internal

  func calculateResult(of operation: IntOperation? = nil) -> Int {
    switch operation ?? self {
      case let .add(lhs, rhs):
        lhs + rhs
      case let .subtract(lhs, rhs):
        lhs - rhs
      case let .divide(numerator, denominator):
        numerator / denominator
      case let .multiply(lhs, rhs):
        lhs * rhs
      case let .freeHand(op):
        calculateResult(of: op)
    }
  }
}

let freehand = IntOperation.freeHand(.multiply(4, 3))
freehand.calculateResult()
