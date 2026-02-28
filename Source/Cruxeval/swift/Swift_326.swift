/// 
func f(text: String) -> Int {
    var number = 0
    for t in text {
        if t.isNumber {
            number += 1
        }
    }
    return number
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
            
assert(f(text: "Thisisastring") == 0)
