import Foundation

func f(text: String, value: String) -> String {
    if !text.contains(value) {
        return ""
    }
    if let range = text.range(of: value, options: .backwards) {
        return String(text[..<range.lowerBound])
    }
    return ""
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
            
assert(f(text: "mmfbifen", value: "i") == "mmfb")
