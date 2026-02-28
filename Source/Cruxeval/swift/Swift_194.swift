/// 
func f(matr: [[Int]], insert_loc: Int) -> [[Int]] {
    var updatedMatrix = matr
    updatedMatrix.insert([], at: insert_loc)
    return updatedMatrix
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
            
assert(f(matr: [[5, 6, 2, 3], [1, 9, 5, 6]], insert_loc: 0) == [[] as [Int], [5, 6, 2, 3], [1, 9, 5, 6]])
