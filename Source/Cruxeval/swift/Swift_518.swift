/// 
func f(text: String) -> Bool {
    return !text.isEmpty && Int(text) == nil
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
            
assert(f(text: "the speed is -36 miles per hour") == true)
