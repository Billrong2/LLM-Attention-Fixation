/// 
func f(nums: [Int]) -> [Int] {
    var nums = nums.filter { $0 > 0 }
    if nums.count <= 3 {
        return nums
    }
    nums.reverse()
    let half = nums.count / 2
    return Array(nums[..<half]) + [0, 0, 0, 0, 0] + Array(nums[half...])
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
            
assert(f(nums: [10, 3, 2, 2, 6, 0]) == [6, 2, 0, 0, 0, 0, 0, 2, 3, 10])
