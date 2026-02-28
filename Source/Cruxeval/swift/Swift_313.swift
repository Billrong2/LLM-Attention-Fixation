/// 
func f(s: String, l: Int) -> String {
    let diff = l - s.count
    var newS = s
    if diff > 0 {
        newS += String(repeating: "=", count: diff)
    }
    if let index = newS.lastIndex(of: "=") {
        return String(newS[..<index])
    }
    return newS
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
            
assert(f(s: "urecord", l: 8) == "urecord")
