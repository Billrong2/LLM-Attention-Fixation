/// 
func f(array: [[Int]]) -> [[Int]] {
    var returnArray: [[Int]] = []
    for a in array {
        returnArray.append(a)
    }
    return returnArray
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
            
assert(f(array: [[1, 2, 3], [] as [Int], [1, 2, 3]]) == [[1, 2, 3], [] as [Int], [1, 2, 3]])
