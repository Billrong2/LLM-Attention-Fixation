/// 
func f(array: [Int], elem: Int) -> Int {
    if let index = array.firstIndex(of: elem) {
        return index
    }
    return -1
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
            
assert(f(array: [6, 2, 7, 1], elem: 6) == 0)
