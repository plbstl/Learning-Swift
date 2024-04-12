import Foundation

let myAge = 22
let yourAge = 21

if myAge > yourAge {
    "I'm older"
} else if myAge < yourAge {
    "I'm younger"
} else {
    "We're age mates"
}

let theirAge = yourAge + 5
let doubleYourAge = yourAge * 2

/// unary prefix !
let done = !true

/// unary suffix !
let name = Optional("Hugo")
type(of: name)
let unaryPostfix = name!
type(of: unaryPostfix)

/// binary infix * + - / < > = && || ??
let egg = "Cow" + "Bull" + " Nintendo"

/// tenary operator
let message = yourAge >= 18
    ? "You're an adult"
    : "You're NOT an adult yet"
