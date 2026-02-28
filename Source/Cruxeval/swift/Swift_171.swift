/// 
func f(nums: [Int]) -> [Int] {
    var nums = nums
    let count = nums.count / 2
    for _ in 0..<count {
        nums.removeFirst()
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
            
assert(f(nums: [3, 4, 1, 2, 3]) == [1, 2, 3])
