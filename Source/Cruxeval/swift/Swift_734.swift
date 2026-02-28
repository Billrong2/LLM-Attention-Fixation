/// 
func f(nums: [Int]) -> [Int] {
    var result = nums
    var i = result.count - 1
    while i >= 0 {
        if result[i] % 2 == 0 {
            result.remove(at: i)
        }
        i -= 1
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
            
assert(f(nums: [5, 3, 3, 7]) == [5, 3, 3, 7])
