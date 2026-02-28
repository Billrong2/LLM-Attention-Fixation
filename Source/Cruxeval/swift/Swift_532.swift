/// 
func f(n: Int, array: [Int]) -> [[Int]] {
    var final: [[Int]] = [array] 
    for _ in 0..<n {
        var arr = array
        arr.append(contentsOf: final.last!)
        final.append(arr)
    }
    return final
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
            
assert(f(n: 1, array: [1, 2, 3]) == [[1, 2, 3], [1, 2, 3, 1, 2, 3]])
