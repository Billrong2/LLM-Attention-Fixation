func f(filename: String) -> Bool {
    let suffix = filename.split(separator: ".").last.map(String.init) ?? ""
    let reversedSuffix = String(suffix.reversed())
    let f2 = filename + reversedSuffix
    return f2.hasSuffix(suffix)
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
            
assert(f(filename: "docs.doc") == false)
