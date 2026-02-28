/// 
func f(d1: [Int : [Int]], d2: [Int : [Int]]) -> Int {
    var mmax = 0
    for (k1, v1) in d1 {
        let p = v1.count + (d2[k1]?.count ?? 0)
        if p > mmax {
            mmax = p
        }
    }
    return mmax
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
            
assert(f(d1: [0 : [] as [Int], 1 : [] as [Int]], d2: [0 : [0, 0, 0, 0], 2 : [2, 2, 2]]) == 4)
