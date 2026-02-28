/// 
func f(nums: [Int], i: Int) -> [Int] {
    var updatedNums = nums
    updatedNums.remove(at: i)
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
            
assert(f(nums: [35, 45, 3, 61, 39, 27, 47], i: 0) == [45, 3, 61, 39, 27, 47])
