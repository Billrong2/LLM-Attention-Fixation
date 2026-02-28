/// 
func f(single_digit: Int) -> [Int] {
    var result: [Int] = []
    for c in 1..<11 {
        if c != single_digit {
            result.append(c)
        }
    }
    return result
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
            
assert(f(single_digit: 5) == [1, 2, 3, 4, 6, 7, 8, 9, 10])
