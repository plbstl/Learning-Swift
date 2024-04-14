import _Concurrency
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// async-let can only be used within asynchronous closures, asynchronous functions
// or wherever a Task is being run.

func calculateFullName(firstName: String, lastName: String) async -> String {
  try? await Task.sleep(for: .seconds(2))
  return "\(firstName) \(lastName)"
}

Task {
  let fullName1 = await calculateFullName(firstName: "Kiki", lastName: "Kofi")

  // another syntax is the async-let

  async let fullName2ChildTask = calculateFullName(firstName: "Foo", lastName: "Bar")
  // you can then manually await the result later on
  let fullName2Result = await fullName2ChildTask
  fullName2Result
}

// MARK: - Cloth

// another example

enum Cloth {
  case shirt, trousers, cap
}

func buyShirt() async throws -> Cloth {
  try await Task.sleep(for: .seconds(2))
  return .shirt
}

func buyTrousers() async throws -> Cloth {
  try await Task.sleep(for: .seconds(2))
  return .trousers
}

func buyCap() async throws -> Cloth {
  try await Task.sleep(for: .seconds(2))
  return .cap
}

// MARK: - Ensemble

/// An ensemble is a group producing a single effect.
///
/// In this context, it is a complete costume of harmonizing or complementary clothing and accessories.
///
/// Basically, a collections of cloth items and/or accessories
struct Ensemble: CustomDebugStringConvertible {
  let clothes: [Cloth]
  let totalPrice: Double

  var debugDescription: String {
    "Clothes = \(clothes); Price = \(totalPrice)"
  }
}

func buyWholeEnsemble() async throws -> Ensemble {
  try await Ensemble(
    clothes: [
      buyShirt(),
      buyTrousers(),
      buyCap(),
    ],
    totalPrice: 282.13
  )
}

Task {
  let ensemble1 = try await buyWholeEnsemble()
  ensemble1
}

Task {
  if let ensemble2 = try? await buyWholeEnsemble() {
    print(ensemble2)
  } else {
    print("Something went wrong. Could not buy ensemble")
  }
}

// async-let can only be used within asynchronous closures, asynchronous functions
// or wherever a Task is being run.

func getFullName(delay: Duration, calculator: () async -> String) async -> String {
  try? await Task.sleep(for: delay)
  return await calculator()
}

func fullName() async -> String { "Foo Bar" }

// same thing
Task {
  await getFullName(delay: .seconds(1)) {
    async let name = fullName()
    return await name
  }
}

// same thing
Task {
  async let fullname = getFullName(delay: .seconds(1), calculator: fullName)
  await print(fullname)
}
