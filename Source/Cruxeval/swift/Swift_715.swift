/// 
func f(text: String, char: String) -> Bool {
    return text.filter { String($0) == char }.count % 2 != 0
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
            
assert(f(text: "abababac", char: "a") == false)
