func f(text: String, value: String) -> String {
    let parts = text.split(separator: Character(value), maxSplits: 1)
    return parts.count > 1 ? String(parts[1]) + String(parts[0]) : ""
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
            
assert(f(text: "difkj rinpx", value: "k") == "j rinpxdif")
