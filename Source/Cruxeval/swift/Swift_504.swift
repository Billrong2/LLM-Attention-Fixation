/// 
func f(values: [Int]) -> [Int] {
    var sortedValues = values
    sortedValues.sort()
    return sortedValues
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
            
assert(f(values: [1, 1, 1, 1]) == [1, 1, 1, 1])
