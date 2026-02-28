import Foundation

func f(text: String) -> String {
    return text.replacingOccurrences(of: "", with: "")
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
            
assert(f(text: "Because it intrigues them") == "Because it intrigues them")
