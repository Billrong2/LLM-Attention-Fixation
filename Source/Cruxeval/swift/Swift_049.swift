import Foundation

func f(text: String) -> String {
    if text.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil {
        return String(text.filter { $0.isNumber })
    } else {
        return String(text)
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
            
assert(f(text: "816") == "816")
