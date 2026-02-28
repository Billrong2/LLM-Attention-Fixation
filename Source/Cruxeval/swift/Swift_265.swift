/// 
func f(d: [Int : Int], k: Int) -> [Int : Int] {
    var new_d: [Int: Int] = [:]
    for (key, val) in d {
        if key < k {
            new_d[key] = val
        }
    }
    return new_d
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
            
assert(f(d: [1 : 2, 2 : 4, 3 : 3], k: 3) == [1 : 2, 2 : 4])
