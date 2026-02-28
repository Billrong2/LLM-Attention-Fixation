/// 
func f(vectors: [[Int]]) -> [[Int]] {
    var sortedVecs: [[Int]] = []
    for var vec in vectors {
        vec.sort()
        sortedVecs.append(vec)
    }
    return sortedVecs
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
            
assert(f(vectors: [] as [[Int]]) == [] as [[Int]])
