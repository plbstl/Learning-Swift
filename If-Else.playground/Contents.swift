import Foundation

let name = "Ragna"
let age = 39

// parenthesis are optional in if statements
// they are helpful when using many logical ANDs and ORs

if name == "ragna" {
    "You really are \(name)"
} else {
    "You are NOT The Chosen One"
}

// another way: if name == "Ragna" && age == 39
if name == "Ragna", age == 39 {
    "I see all things"
} else if name == "Ragnar" {
    "Imposter"
} else if age > 112 {
    "Where have you been?!"
} else {
    "No hope"
}

if name == "Ragnar" || age < 40 {
    "There really is hope"
} else {
    "Time to give in"
}
