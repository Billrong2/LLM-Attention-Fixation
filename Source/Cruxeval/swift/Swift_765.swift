/// 
func f(text: String) -> Int {
    return text.reduce(0) { $0 + ($1.isNumber ? 1 : 0) }
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
            
assert(f(text: "so456") == 3)
