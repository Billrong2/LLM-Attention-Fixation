/// 
func f(nums: [Int]) -> [Int] {
    var nums = nums
    let count = nums.count
    for i in stride(from: nums.count - 1, through: 0, by: -1) {
        nums.insert(nums.removeFirst(), at: i)
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
            
assert(f(nums: [0, -5, -4]) == [-4, -5, 0])
