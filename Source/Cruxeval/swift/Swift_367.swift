/// 
func f(nums: [Int], rmvalue: Int) -> [Int] {
    var res = nums
    while res.contains(rmvalue) {
        if let index = res.firstIndex(of: rmvalue) {
            let popped = res.remove(at: index)
            if popped != rmvalue {
                res.append(popped)
            }
        }
    }
    return res
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
            
assert(f(nums: [6, 2, 1, 1, 4, 1], rmvalue: 5) == [6, 2, 1, 1, 4, 1])
