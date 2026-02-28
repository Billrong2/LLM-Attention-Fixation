/// 
func f(nums: [Int]) -> String {
    var reversedNums = nums.reversed().map { String($0) }
    return reversedNums.joined()
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
            
assert(f(nums: [-1, 9, 3, 1, -2]) == "-2139-1")
