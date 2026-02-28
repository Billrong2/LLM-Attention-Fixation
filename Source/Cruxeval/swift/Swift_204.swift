func f(name: String) -> [String] {
    let firstChar = String(name[name.startIndex])
    let secondChar = String(name[name.index(after: name.startIndex)])
    return [firstChar, secondChar]
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
            
assert(f(name: "master. ") == ["m", "a"])
