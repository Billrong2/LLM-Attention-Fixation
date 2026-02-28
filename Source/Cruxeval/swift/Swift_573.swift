/// 
func f(string: String, prefix: String) -> String {
    if string.hasPrefix(prefix) {
        return String(string.dropFirst(prefix.count))
    }
    return string
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
            
assert(f(string: "Vipra", prefix: "via") == "Vipra")
