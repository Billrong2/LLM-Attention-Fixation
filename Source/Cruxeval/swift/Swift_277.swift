/// 
func f(lst: [Int], mode: Int) -> [Int] {
    var result = lst
    if mode != 0 {
        result.reverse()
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
            
assert(f(lst: [1, 2, 3, 4], mode: 1) == [4, 3, 2, 1])
