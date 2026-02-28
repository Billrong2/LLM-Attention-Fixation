func f(temp: Int, timeLimit: Int) -> String {
    let s = timeLimit / temp
    let e = timeLimit % temp
    return [String("\(e) oC"), String("\(s) \(e)")][s > 1 ? 1 : 0]
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
            
assert(f(temp: 1, timeLimit: 1234567890) == "1234567890 0")
