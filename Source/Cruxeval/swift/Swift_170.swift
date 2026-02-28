/// 
func f(nums: [Int], number: Int) -> Int {
    return nums.filter{$0 == number}.count
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
            
assert(f(nums: [12, 0, 13, 4, 12], number: 12) == 2)
