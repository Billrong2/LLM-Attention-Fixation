/// 
func f(nums: [Int]) -> [Int] {
    var nums = nums
    let count = nums.count
    if count == 0 {
        nums = Array(repeating: 0, count: nums.removeLast())
    } else if count % 2 == 0 {
        nums.removeAll()
    } else {
        nums.removeFirst(count / 2)
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
            
assert(f(nums: [-6, -2, 1, -3, 0, 1]) == [] as [Int])
