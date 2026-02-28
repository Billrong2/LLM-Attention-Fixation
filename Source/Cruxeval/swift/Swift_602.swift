/// 
func f(nums: [Int], target: Int) -> Int {
    let cnt = nums.filter { $0 == target }.count
    return cnt * 2
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
            
assert(f(nums: [1, 1], target: 1) == 4)
