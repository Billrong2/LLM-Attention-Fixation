import Foundation

func f(s: String) -> String {
    return s.replacingOccurrences(of: "a", with: "")
           .replacingOccurrences(of: "r", with: "")
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
            
assert(f(s: "rpaar") == "p")
