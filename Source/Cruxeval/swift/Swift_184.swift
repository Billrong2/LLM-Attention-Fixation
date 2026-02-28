/// 
func f(digits: [Int]) -> [Int] {
    var digits = digits
    digits.reverse()
    if digits.count < 2 {
        return digits
    }
    
    for i in stride(from: 0, to: digits.count, by: 2) {
        if i + 1 < digits.count {
            digits.swapAt(i, i + 1)
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
            
assert(f(digits: [1, 2]) == [1, 2])
