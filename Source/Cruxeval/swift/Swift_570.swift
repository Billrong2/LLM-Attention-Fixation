/// 
func f(array: [Int], index: Int, value: Int) -> [Int] {
    var newArray = array
    newArray.insert(index + 1, at: 0)
    if value >= 1 {
        newArray.insert(value, at: index)
    }
    return newArray
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
            
assert(f(array: [2], index: 0, value: 2) == [2, 1, 2])
