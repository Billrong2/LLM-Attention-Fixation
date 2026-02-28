/// 
func f(nums: [Int], pop1: Int, pop2: Int) -> [Int] {
    var updatedNums = nums
    updatedNums.remove(at: pop1 - 1)
    updatedNums.remove(at: pop2 - 1)
    return updatedNums
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
            
assert(f(nums: [1, 5, 2, 3, 6], pop1: 2, pop2: 4) == [1, 2, 3])
