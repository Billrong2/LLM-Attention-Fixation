/// 
func f(nums: [Int], odd1: Int, odd2: Int) -> [Int] {
    var nums = nums
    while nums.contains(odd1) {
        if let index = nums.firstIndex(of: odd1) {
            nums.remove(at: index)
        }
    }
    while nums.contains(odd2) {
        if let index = nums.firstIndex(of: odd2) {
            nums.remove(at: index)
        }
    }
    return nums
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
            
assert(f(nums: [1, 2, 3, 7, 7, 6, 8, 4, 1, 2, 3, 5, 1, 3, 21, 1, 3], odd1: 3, odd2: 1) == [2, 7, 7, 6, 8, 4, 2, 5, 21])
