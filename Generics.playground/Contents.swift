import Foundation

func perfom<N: Numeric>(
  _ op: (N, N) -> N,
  on lhs: N,
  and rhs: N
)
  -> N
{
  op(lhs, rhs)
}

perfom(+, on: 3, and: 5)
perfom(-, on: 3.1, and: 5)
perfom(/, on: 3, and: 5.0)
perfom(*, on: 3, and: 5)

// alternative approach

func perfom2<N>(
  _ op: (N, N) -> N,
  on lhs: N,
  and rhs: N
)
  -> N where N: Numeric
{
  op(lhs, rhs)
}

perfom2(+, on: 3.0, and: 5)

// MARK: - CanJump

// conform to multiple types

protocol CanJump {
  func jump()
}

// MARK: - CanRun

protocol CanRun {
  func run()
}

// MARK: - Person

struct Person: CanJump, CanRun {
  func jump() {
    "Jumping..."
  }

  func run() {
    "Running..."
  }
}

func jumpThenRun<T: CanJump & CanRun>(_ value: T) {
  value.jump()
  value.run()
}

let person1 = Person()
jumpThenRun(person1)

// generics with built-in

extension [String] {
  /// Returns the longest string in the array. `nil` is returned if the array is empty.
  ///
  /// If there are multiple strings with the same longest length, the first longest string in the array is returned.
  func longestStringMe() -> String? {
    if isEmpty {
      return nil
    }

    var longestString = ""
    for currentString in self {
      longestString =
        currentString.count > longestString.count
          ? currentString
          : longestString
    }

    return longestString
  }

  func longestStringTutor() -> String? {
    sorted {
      lhs, rhs in lhs.count > rhs.count
    }
    .first
  }
}

let example1 = ["A", "list", "of", "chars", "barss"]

example1.longestStringMe()
example1.longestStringTutor()

extension [Int] {
  /// Returns the average of all numbers in the array.
  func average() -> Double {
    Double(reduce(0, +)) / Double(count)
  }
}

[1, 2, 3, 4].average()

// MARK: - View

// using generics with protocols
// it can happen by using associated types
// use associatedtype keyword

protocol View {
  func addSubView(_: View)
}

// MARK: - PresentableAsView

protocol PresentableAsView {
  associatedtype ViewType: View
  func configure(superView: View, thisView: ViewType)
  func present(view: ViewType, on superView: View)
  func produceView() -> ViewType
}

extension PresentableAsView {
  func present(view: ViewType, on superView: View) {
    superView.addSubView(view)
  }
}

extension PresentableAsView where ViewType == Button {
  func doSomethingWithButton() {}
}

// MARK: - Button

struct Button: View {
  func addSubView(_: View) {
    // empty
  }
}

// MARK: - MyButton

struct MyButton: PresentableAsView {
  func configure(superView _: View, thisView _: Button) {
    //
  }

  func produceView() -> Button {
    Button()
  }
}

let btn = MyButton()
btn.doSomethingWithButton()

// MARK: - Table

struct Table: View {
  func addSubView(_: View) {
    //
  }
}

// MARK: - MyTable

struct MyTable: PresentableAsView {
  func configure(superView _: View, thisView _: Table) {
    //
  }

  func produceView() -> Table {
    Table()
  }
}

let table1 = MyTable()
table1.produceView()

btn.present(view: Button(), on: Table())
