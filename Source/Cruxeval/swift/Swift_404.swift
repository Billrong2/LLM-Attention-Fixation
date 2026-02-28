/// 
func f(no: [String]) -> Int {
    var d = [String: Bool]()
    no.forEach { d[$0] = false }
    return d.keys.count
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
            
assert(f(no: ["l", "f", "h", "g", "s", "b"]) == 6)
