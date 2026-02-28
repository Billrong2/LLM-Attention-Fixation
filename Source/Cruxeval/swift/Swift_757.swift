import Foundation

func f(text: String, char: String, replace: String) -> String {
    return text.replacingOccurrences(of: char, with: replace)
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
            
assert(f(text: "a1a8", char: "1", replace: "n2") == "an2a8")
