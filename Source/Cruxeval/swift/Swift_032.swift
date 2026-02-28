func f(s: String, sep: String) -> String {
    let reverse = s.split(separator: Character(sep)).map { "*" + String($0) }
    return reverse.reversed().joined(separator: ";")
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
            
assert(f(s: "volume", sep: "l") == "*ume;*vo")
