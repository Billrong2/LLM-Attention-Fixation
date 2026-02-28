/// 
func f(num1: Int, num2: Int, num3: Int) -> String {
    var nums = [num1, num2, num3]
    nums.sort()
    return "\(nums[0]),\(nums[1]),\(nums[2])"
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
            
assert(f(num1: 6, num2: 8, num3: 8) == "6,8,8")
