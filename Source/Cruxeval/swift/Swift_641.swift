import Foundation

func f(number: String) -> Bool {
    return number.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
}


func ==(left: [(Int, Int)], right: [(Int, Int)]) -> Bool {
    if left.count != right.count {
        return false
    }
    for (l, r) in zip(left, right) {
        if l != r {
            return false
        }
    }
    return true
}
            
assert(f(number: "dummy33;d") == false)
