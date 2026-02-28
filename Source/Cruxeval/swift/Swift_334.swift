/// 
func f(a: String, b: [String]) -> String {
    return b.joined(separator: a)
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
            
assert(f(a: "00", b: ["nU", " 9 rCSAz", "w", " lpA5BO", "sizL", "i7rlVr"]) == "nU00 9 rCSAz00w00 lpA5BO00sizL00i7rlVr")
