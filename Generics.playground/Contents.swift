import Foundation

func testt(
    val: Int, vall: Int
)
    -> String
{
    if val > vall {
        return "I'm older"
    } else if val < vall {
        return "I'm younger"
    } else {
        return "We're age mates"
    }
}

testt(val: 2, vall: 2)

func foo(_ condition: Bool) -> String {
    if condition {
        return "foo"
    } else {
        return "bar"
    }
}

foo(true)

// MARK: - Foo

// swiftformat:sort
enum Foo: String {
    case bar
    case baz = "quux"
}

func customAdd(
    lhs: Int,
    rhs: Int,
    fn: (Int, Int) -> Int
)
    -> Int
{
    fn(lhs, rhs)
}
