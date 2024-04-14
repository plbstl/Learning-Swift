import Foundation

// let prevents mutability. exception is if assigned to a class (reference types) that can mutate itself internally

// values types (structures), reference types (classes)

let greeting = "Hello, playground"

var list = [
  greeting,
  "Cool ins",
]

list = ["New"]

list.append("Old")
