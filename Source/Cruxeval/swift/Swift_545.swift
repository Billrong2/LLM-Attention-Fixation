/// 
func f(array: [Int]) -> [Int] {
    var result: [Int] = []
    var index = 0
    var tempArray = array

    while index < tempArray.count {
        result.append(tempArray.removeLast())
        index += 2
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
            
assert(f(array: [8, 8, -4, -9, 2, 8, -1, 8]) == [8, -1, 8])
