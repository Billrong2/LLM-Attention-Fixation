/// 
func f(L: [Int]) -> [Int] {
    var result = L
    let N = result.count
    for k in 1...(N/2) {
        var i = k - 1
        var j = N - k
        while i < j {
            // swap elements:
            (result[i], result[j]) = (result[j], result[i])
            // update i, j:
            i += 1
            j -= 1
        }
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
            
assert(f(L: [16, 14, 12, 7, 9, 11]) == [11, 14, 7, 12, 9, 16])
