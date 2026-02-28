/// 
func f(nums: [Int]) -> [Int] {
    var nums = nums
    var a = -1
    var b = Array(nums[1...])
    while a <= b[0] {
        nums.removeAll(where: { $0 == b[0] })
        a = 0
        b = Array(b.dropFirst())
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
            
assert(f(nums: [-1, 5, 3, -2, -6, 8, 8]) == [-1, -2, -6, 8, 8])
