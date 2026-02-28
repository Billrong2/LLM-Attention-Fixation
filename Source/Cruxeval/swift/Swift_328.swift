/// 
func f(array: [Int], L: Int) -> [Int] {
    if L <= 0 {
        return array
    } else if array.count < L {
        var newArray = [Int]()
        for _ in 0..<(L - array.count) {
            newArray += array
        }
        return array + newArray
    }
    return array
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
            
assert(f(array: [1, 2, 3], L: 4) == [1, 2, 3, 1, 2, 3])
