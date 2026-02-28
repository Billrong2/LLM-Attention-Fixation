/// 
func f(text: String) -> Bool {
    for c in text {
        if !c.isNumber {
            return false
        }
    }
    return !text.isEmpty
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
            
assert(f(text: "99") == true)
