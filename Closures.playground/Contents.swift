import Foundation

// in Swift, any function that doesn't have the func keyword is pretty much a closure

// maybe think of them as function expressions in javascript?

// func add(_ lhs: Int, _ rhs: Int) -> Int {
//    lhs + rhs
// }

/// function closures
let add: (Int, Int) -> Int = { (lhs: Int, rhs: Int) -> Int in
    lhs + rhs
}

let addStyle2: (Int, Int) -> Int = { lhs, rhs in
    lhs + rhs
}

let addStyle3: (Int, Int) -> Int = { $0 + $1 }

add(91, 21)

/// pass function as argument
func customAdd(
    lhs: Int,
    rhs: Int,
    fn: (Int, Int) -> Int) -> Int
{
    fn(lhs, rhs)
}

customAdd(lhs: 8, rhs: 8, fn: add)

// using a Trailing Closure Syntax.
// requirement is last argument is a closure
customAdd(lhs: 9, rhs: 9)
{ lhs, rhs in
    lhs + rhs
}

customAdd(lhs: 9, rhs: 9, fn: +)

/// using a Trailing Closure Syntax. example 2
func customPlus(
    _ lhs: Int,
    _ rhs: Int,
    using function: (Int, Int) -> Int) -> Int
{
    function(lhs, rhs)
}

customPlus(21, 4) { $0 + $1 }

/// cool stuff, 3 different ways to write the sorted by func
let ages = [91, 70, 42, 38, 21, 109]

ages.sorted(by: { (lhs: Int, rhs: Int) -> Bool in
    lhs < rhs
})

ages.sorted
{ lhs, rhs in
    lhs < rhs
}

ages.sorted(by: <)
ages.sorted(by: >)
