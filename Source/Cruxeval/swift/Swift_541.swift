/// 
func f(text: String) -> Bool {
    return text.filter{ !$0.isWhitespace }.isEmpty
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
            
assert(f(text: " \t  　") == true)
