/// 
func f(nums: [Int]) -> Int {
    var counts = 0
    for i in nums {
        if let _ = Int(String(i)) {
            if counts == 0 {
                counts += 1
            }
        }
    }
    return counts
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
            
assert(f(nums: [0, 6, 2, -1, -2]) == 1)
