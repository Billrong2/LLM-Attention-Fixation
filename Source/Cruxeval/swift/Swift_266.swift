/// 
func f(nums: [Int]) -> [Int] {
    var updatedNums = nums
    for i in stride(from: nums.count - 1, through: 0, by: -1) {
        if updatedNums[i] % 2 == 1 {
            updatedNums.insert(updatedNums[i], at: i + 1)
        }
    }
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
            
assert(f(nums: [2, 3, 4, 6, -2]) == [2, 3, 3, 4, 6, -2])
