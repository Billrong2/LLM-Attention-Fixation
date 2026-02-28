import Foundation

func f(text: String, dng: String) -> String {
    if !text.contains(dng) {
        return text
    }
    if text.suffix(dng.count) == dng {
        return String(text.dropLast(dng.count))
    }
    return f(text: String(text.dropLast()), dng: dng)
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
            
assert(f(text: "catNG", dng: "NG") == "cat")
