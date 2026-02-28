extension Array: Error {}

func f(nums: [Int]) -> Result<Bool, [Int]> {
    for i in stride(from: nums.count-1, through: 0, by: -3) {
        if nums[i] == 0 {
            return .success(false)
        }
    }
    return .failure(nums)
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
            
assert(f(nums: [0, 0, 1, 2, 1]) == .success(false))
