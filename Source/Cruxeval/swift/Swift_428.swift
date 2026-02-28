/// 
func f(nums: [Int]) -> [Int] {
    var result = nums
    for i in 0..<result.count {
        if i % 2 == 0 {
            result.append(result[i] * result[i + 1])
        }
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
            
assert(f(nums: [] as [Int]) == [] as [Int])
