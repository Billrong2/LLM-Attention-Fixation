/// 
func f(cat: String) -> Int {
    var digits = 0
    for char in cat {
        if char.isNumber {
            digits += 1
        }
    }
    return digits
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
            
assert(f(cat: "C24Bxxx982ab") == 5)
