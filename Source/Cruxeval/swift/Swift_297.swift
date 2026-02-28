/// 
func f(num: Int) -> String {
    if 0 < num && num < 1000 && num != 6174 {
        return "Half Life"
    }
    return "Not found"
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
            
assert(f(num: 6173) == "Not found")
