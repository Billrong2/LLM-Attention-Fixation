/// 
func f(array: [Int], index: Int) -> Int {
    var newIndex = index
    if newIndex < 0 {
        newIndex = array.count + newIndex
    }
    return array[newIndex]
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
            
assert(f(array: [1], index: 0) == 1)
