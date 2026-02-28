/// 
func f(nums: [Int]) -> String {
    var nums = nums
    nums.removeAll()
    return "quack"
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
            
assert(f(nums: [2, 5, 1, 7, 9, 3]) == "quack")
