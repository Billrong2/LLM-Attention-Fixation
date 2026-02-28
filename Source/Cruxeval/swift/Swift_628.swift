/// 
func f(nums: [Int], delete: Int) -> [Int] {
    var updatedNums = nums
    if let index = updatedNums.firstIndex(of: delete) {
        updatedNums.remove(at: index)
    }
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
            
assert(f(nums: [4, 5, 3, 6, 1], delete: 5) == [4, 3, 6, 1])
