import Foundation

func f(text: String, suffix: String) -> String {
    if !suffix.isEmpty, let lastChar = suffix.last, text.contains(lastChar) {
        let trimmedText = text.hasSuffix(String(lastChar)) ? String(text.dropLast()) : text
        return f(text: trimmedText, suffix: String(suffix.dropLast()))
    } else {
        return text
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
            
assert(f(text: "rpyttc", suffix: "cyt") == "rpytt")
