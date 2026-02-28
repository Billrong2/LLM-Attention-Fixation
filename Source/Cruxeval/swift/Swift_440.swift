import Foundation

func f(text: String) -> String {
    if text.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil {
        return "yes"
    } else {
        return "no"
    }
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
            
assert(f(text: "abc") == "no")
