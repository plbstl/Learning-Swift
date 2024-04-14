import Foundation

func camelCase() {
  print("Nothing is happening")
}

camelCase()

/// nomal function
func plusTwo(value: Int) {
  let newValue = value + 2
}

plusTwo(value: 9)

/// implicit return the only expression
func plus2(value: Int) -> Int {
  // does not need a return keyword
  value + 2
}

plus2(value: 3)

/// multiple params
func plus(value1: Int, value2: Int) {
  value1 + value2
}

plus(value1: 5, value2: 9)

/// without argument label - no real world reason to do this
func setToFive(_: String) {
  _ = 5
}

setToFive("s")

/// different external name
func add(_ value1: Int, _ value2: Int) -> Int {
  value1 + value2
}

func divide(number numerator: Int, by denominator: Int) -> Int {
  numerator / denominator
}

add(8, 010)
divide(number: 24, by: 8)
// func divide(this numerator: Int, by denominator: Int) -> Int {

/// disposable function. consuming the return value is optional
@discardableResult func substract(_ lhs: Int, _ rhs: Int) -> Int {
  lhs - rhs
}

substract(14, 9)

/// functions inside functions
func doSomethingComplicated(with value: Int) -> Int {
  func mainLogic(_ value: Int) -> Int {
    value + 3
  }
  return mainLogic(value + 4)
}

doSomethingComplicated(with: 13)

/// using default values
func getFullName(firstname: String = "Ragnar", lastname: String = "Crimson") -> String {
  "\(firstname) \(lastname)"
}

getFullName()
getFullName(firstname: "Jon", lastname: "Snow")
getFullName(lastname: "Locbruk")
