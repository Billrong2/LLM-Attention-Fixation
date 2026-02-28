/// 
func f(s: String) -> String {
    return String(s.reversed().filter({$0 != " "}))
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
            
assert(f(s: "ab        ") == "ba")
