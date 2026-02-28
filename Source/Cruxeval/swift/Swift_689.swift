/// 
func f(arr: [Int]) -> [Int] {
    var sub = arr
    for i in stride(from: 0, to: sub.count, by: 2) {
        sub[i] *= 5
    }
    return sub
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
            
assert(f(arr: [-3, -6, 2, 7]) == [-15, -6, 10, 7])
