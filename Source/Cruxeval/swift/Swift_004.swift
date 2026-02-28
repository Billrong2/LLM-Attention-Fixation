/// 
func f(array: [String]) -> String {
    var s = " "
    s += array.joined()
    return s
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
            
assert(f(array: [" ", "  ", "    ", "   "]) == "           ")
