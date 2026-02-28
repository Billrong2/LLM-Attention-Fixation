/// 
func f(nums: [Int], target: Int) -> Int {
    if nums.filter({ $0 == 0 }).count > 0 {
        return 0
    } else if nums.filter({ $0 == target }).count < 3 {
        return 1
    } else {
        return nums.firstIndex(of: target) ?? 0
    }
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
            
assert(f(nums: [1, 1, 1, 2], target: 3) == 1)
