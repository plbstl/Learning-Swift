import Foundation

// foundation has lots of operators, but not all cases

let firstName: String? = "Foo "
let lastName: String? = "Bar"
let fullName = firstName + lastName

// custom binary infix

func + (lhs: String?, rhs: String?) -> String? {
  switch (lhs, rhs) {
    case (.none, .none):
      nil
    case let (.none, .some(value)), let (.some(value), .none):
      value
    case let (.some(lhs), .some(rhs)):
      lhs + rhs
  }
}

// custom unary prefix

prefix operator ^
prefix func ^ (value: String) -> String {
  value.uppercased()
}

let name = "Azula Minna"
let uppercasedName = ^name

// custom unary postfix (suffix)

postfix operator ~
postfix func ~ (value: String) -> String {
  "~ \(value.lowercased()) ~"
}

let lowercasedName = uppercasedName~

// MARK: - Humanoid

struct Humanoid {
  let name: String
}

// MARK: - Family

struct Family {
  let members: [Humanoid]
}

// custom binary infix for unrelated types

func + (lhs: Humanoid, rhs: Humanoid) -> Family {
  Family(members: [lhs, rhs])
}

func + (lhs: Family, rhs: Humanoid) -> Family {
  var members = lhs.members
  members.append(rhs)
  return Family(members: members)
}

func + (lhs: Family, rhs: [Humanoid]) -> Family {
  var members = lhs.members
  members.append(contentsOf: rhs)
  return Family(members: members)
}

func + (lhs: Family, rhs: Family) -> Family {
  var membersOfFirstFamily = lhs.members
  var membersOfSecondFamily = rhs.members
  membersOfFirstFamily.append(contentsOf: membersOfSecondFamily)
  return Family(members: membersOfFirstFamily)
}

let dad = Humanoid(name: "Dad")
let mom = Humanoid(name: "Mom")
let daughter = Humanoid(name: "Daughter")
let son1 = Humanoid(name: "Son 1")
let son2 = Humanoid(name: "Son 2")

let family = dad + mom
family.members.first?.name
family.members.last?.name
family.members.count

let newFamily = family + son1
newFamily.members.last?.name
newFamily.members.count

let familyWithSons = family + [son1, son2]
familyWithSons.members.last?.name
familyWithSons.members.count

let bigFamily = family + newFamily
bigFamily.members.last?.name
bigFamily.members.count

// how do i get this to work?
// let family2 = dad + mom + daughter
