func f(text: String, value: String) -> String {
    if text.lowercased().hasPrefix(value.lowercased()) {
        return String(text.dropFirst(value.count))
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
            
assert(f(text: "coscifysu", value: "cos") == "cifysu")
