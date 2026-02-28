/// 
func f(nums: [Int], target: Int) -> Int {
    var count = 0
    for n1 in nums {
        for n2 in nums {
            count += (n1 + n2 == target) ? 1 : 0
        }
    }
    return count
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
            
assert(f(nums: [1, 2, 3], target: 4) == 3)
