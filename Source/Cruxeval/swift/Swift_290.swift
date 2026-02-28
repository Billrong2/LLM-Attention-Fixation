import Foundation

func f(text: String, prefix: String) -> String {
    if text.hasPrefix(prefix) {
        return String(text.dropFirst(prefix.count))
    }
    if text.contains(prefix) {
        return text.replacingOccurrences(of: prefix, with: "").trimmingCharacters(in: .whitespaces)
    }
    return text.uppercased()
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
            
assert(f(text: "abixaaaily", prefix: "al") == "ABIXAAAILY")
