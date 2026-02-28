import Foundation

func f(test_str: String) -> String {
    var s = test_str.replacingOccurrences(of: "a", with: "A")
    s = s.replacingOccurrences(of: "e", with: "A")
    return s
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
            
assert(f(test_str: "papera") == "pApArA")
