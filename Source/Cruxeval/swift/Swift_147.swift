/// 
func f(nums: [Int]) -> [Int] {
    let middle = nums.count / 2
    return Array(nums[middle..<nums.count]) + Array(nums[0..<middle])
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
            
assert(f(nums: [1, 1, 1]) == [1, 1, 1])
