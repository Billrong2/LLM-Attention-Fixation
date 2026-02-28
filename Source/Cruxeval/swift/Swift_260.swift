/// 
func f(nums: [Int], start: Int, k: Int) -> [Int] {
    var updatedNums = nums
    updatedNums.replaceSubrange(start..<start+k, with: nums[start..<start+k].reversed())
    return updatedNums
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
            
assert(f(nums: [1, 2, 3, 4, 5, 6], start: 4, k: 2) == [1, 2, 3, 4, 6, 5])
