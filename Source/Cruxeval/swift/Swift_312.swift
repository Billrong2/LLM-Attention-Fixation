import Foundation

func f(s: String) -> String {
    if s.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil {
        return "True"
    }
    return "False"
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
            
assert(f(s: "777") == "True")
