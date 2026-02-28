/// 
func f(text: String) -> Int {
    let parts = text.split(separator: ",")
    let string_a = String(parts[0])
    let string_b = String(parts[1])
    return -(string_a.count + string_b.count)
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
            
assert(f(text: "dog,cat") == -6)
