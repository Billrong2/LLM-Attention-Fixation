/// 
func f(text: String) -> Bool {
    var b = true
    for x in text {
        if x.isNumber {
            b = true
        } else {
            b = false
            break
        }
    }
    return b
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
            
assert(f(text: "-1-3") == false)
