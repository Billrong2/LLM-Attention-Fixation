func f(text: String) -> Int {
    return text.split(separator: ":")[0].filter({$0 == "#"}).count
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
            
assert(f(text: "#! : #!") == 1)
