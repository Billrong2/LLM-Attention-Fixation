func f(s: String, separator: String) -> String {
    var new_s = Array(s)
    for i in 0..<s.count {
        if String(new_s[i]) == separator {
            new_s[i] = "/"
            return new_s.map { String($0) }.joined(separator: " ")
        }
    }
    return s
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
            
assert(f(s: "h grateful k", separator: " ") == "h / g r a t e f u l   k")
