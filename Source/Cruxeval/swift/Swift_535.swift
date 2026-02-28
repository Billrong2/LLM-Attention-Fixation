/// 
func f(n: Int) -> Bool {
    for digit in String(n) {
        if digit != "0" && digit != "1" && !(5...9).contains(Int(String(digit)) ?? 0) {
            return false
        }
    }
    return true
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
            
assert(f(n: 1341240312) == false)
