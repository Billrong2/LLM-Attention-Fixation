/// 
func f(matrix: [[Int]]) -> [[Int]] {
    var reversedMatrix = matrix.reversed()
    var result: [[Int]] = []
    for var primary in reversedMatrix {
        primary.sort(by: >)
        result.append(primary)
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
            
assert(f(matrix: [[1, 1, 1, 1]]) == [[1, 1, 1, 1]])
