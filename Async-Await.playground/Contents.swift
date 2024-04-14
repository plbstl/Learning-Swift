import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// MARK: - NetworkService

// mock network requests. think of `completion` as `done`

enum NetworkService {
  static func request(delay: Double, completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
      completion()
    }
  }
}

// we want to encrypt a number using a backend, sending multiple requests

func add(num: Int, completion: @escaping (Int) -> Void) {
  NetworkService.request(delay: 1) {
    completion(num + 5)
  }
}

func substract(num: Int, completion: @escaping (Int) -> Void) {
  NetworkService.request(delay: 2) {
    completion(num - 1)
  }
}

func mulitply(num: Int, completion: @escaping (Int) -> Void) {
  NetworkService.request(delay: 3) {
    completion(num * 10)
  }
}

func divide(num: Int, completion: @escaping (Int) -> Void) {
  NetworkService.request(delay: 4) {
    completion(num / 2)
  }
}

// callback hell

func encrypt(num: Int) {
  mulitply(num: num) { multipliedValue in
    "Level 1 encryption: \(multipliedValue)"
    substract(num: multipliedValue) { substractedValue in
      "Level 2 encryption: \(substractedValue)"
      divide(num: substractedValue) { dividedValue in
        "Level 3 encryption: \(dividedValue)"
        add(num: dividedValue) { cipherText in
          "Final encryption: \(cipherText)"
        }
      }
    }
  }
}

encrypt(num: 7) // 39

// MARK: - NetworkServiceAsync

// now lets change it to Async Await

enum NetworkServiceAsync {
  static func request<T: Any>(delay: Double, perform op: () -> T) async throws -> T {
    try await Task.sleep(for: .seconds(delay))
    return op()
  }
}

// we want to encrypt a number using a backend, sending multiple requests

func addAsync(num: Int) async throws -> Int {
  try await NetworkServiceAsync.request(delay: 1) { num + 5 }
}

func substractAsync(num: Int) async throws -> Int {
  try await NetworkServiceAsync.request(delay: 2) { num - 1 }
}

func mulitplyAsync(num: Int) async throws -> Int {
  try await NetworkServiceAsync.request(delay: 3) { num * 10 }
}

func divideAsync(num: Int) async throws -> Int {
  try await NetworkServiceAsync.request(delay: 4) { num / 2 }
}

// we can send a result and failure for success and error. we'll do this in a duplicate function

func encryptAsync(num: Int) async -> Int? {
  do {
    let multipliedValue = try await mulitplyAsync(num: num)
    "Level 1 encryption: \(multipliedValue)"

    let substractedValue = try await substractAsync(num: multipliedValue)
    "Level 2 encryption: \(substractedValue)"

    let dividedValue = try await divideAsync(num: substractedValue)
    "Level 3 encryption: \(dividedValue)"

    let cipherText = try await addAsync(num: dividedValue)
    "Final encryption: \(cipherText)"

    return cipherText

  } catch {
    "An error occured: \(error)"
    return nil
  }
}

Task {
  let cipherText = await encryptAsync(num: 7)
  cipherText // 39
}

// MARK: - EncryptionErrors

// we can send a result and failure for success and error

enum EncryptionErrors: Error {
  case cannotEncryptNumber(value: Int)
}

func encryptAsyncResult(num: Int) async -> Result<Int, EncryptionErrors> {
  do {
    let multipliedValue = try await mulitplyAsync(num: num)
    "Level 1 encryption: \(multipliedValue)"

    let substractedValue = try await substractAsync(num: multipliedValue)
    "Level 2 encryption: \(substractedValue)"

    let dividedValue = try await divideAsync(num: substractedValue)
    "Level 3 encryption: \(dividedValue)"

    let cipherText = try await addAsync(num: dividedValue)
    "Final encryption: \(cipherText)"

    return Result.success(cipherText)

  } catch {
    "An error occured: \(error)"
    return Result.failure(EncryptionErrors.cannotEncryptNumber(value: num))
  }
}

Task {
  let cipherText = await encryptAsyncResult(num: 7)

  switch cipherText {
    case let .success(cipherText):
      "Cipher text is: \(cipherText)" // 39

    case let .failure(error):
      switch error {
        case let .cannotEncryptNumber(value):
          "Cannot encrypt number: \(value)"
      }
  }

  cipherText // 39
}

// MARK: - NetworkServiceAsyncTut

// now lets change it to Async Await from tutorial

enum NetworkServiceAsyncTut {
  static func request(delay: Double) async {
    try? await Task.sleep(for: .seconds(delay))
  }
}

// we want to encrypt a number using a backend, sending multiple requests

func addAsyncTut(num: Int) async -> Int {
  await NetworkServiceAsyncTut.request(delay: 1)
  return num + 5
}

func substractAsyncTut(num: Int) async -> Int {
  await NetworkServiceAsyncTut.request(delay: 2)
  return num - 1
}

func mulitplyAsyncTut(num: Int) async -> Int {
  await NetworkServiceAsyncTut.request(delay: 3)
  return num * 10
}

func divideAsyncTut(num: Int) async -> Int {
  await NetworkServiceAsyncTut.request(delay: 4)
  return num / 2
}

func encryptTut(num: Int) {
  Task {
    var cipherText = await mulitplyAsyncTut(num: num)
    "Level 1 encryption: \(cipherText)"

    cipherText = await substractAsyncTut(num: cipherText)
    "Level 2 encryption: \(cipherText)"

    cipherText = await divideAsyncTut(num: cipherText)
    "Level 3 encryption: \(cipherText)"

    cipherText = await addAsyncTut(num: cipherText)
    "Final encryption: \(cipherText)" // 39
  }
}

encryptTut(num: 7) // 39
