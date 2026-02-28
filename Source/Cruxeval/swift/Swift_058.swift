/// 
func f(nums: [Int]) -> [Int] {
    var result = nums
    let count = nums.count
    
    for i in 0..<count {
        result.append(nums[i % 2])
    }
    
    return result
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
            
assert(f(nums: [-1, 0, 0, 1, 1]) == [-1, 0, 0, 1, 1, -1, 0, -1, 0, -1])
