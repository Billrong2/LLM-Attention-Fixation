/// 
func f(nums: [Int], sort_count: Int) -> [Int] {
    var sortedNums = nums.sorted()
    return Array(sortedNums.prefix(sort_count))
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
            
assert(f(nums: [1, 2, 2, 3, 4, 5], sort_count: 1) == [1])
