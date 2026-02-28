import Foundation

func f(s: String) -> String {
    if s.rangeOfCharacter(from: CharacterSet.letters.inverted) == nil {
        return "yes"
    } else if s.isEmpty {
        return "str is empty"
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
            
assert(f(s: "Boolean") == "yes")
