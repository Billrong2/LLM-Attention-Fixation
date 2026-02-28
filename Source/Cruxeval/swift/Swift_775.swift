/// 
func f(nums: [Int]) -> [Int] {
    var reversedNums = nums
    let count = reversedNums.count
    for i in 0..<(count / 2) {
        let temp = reversedNums[i]
        reversedNums[i] = reversedNums[count - i - 1]
        reversedNums[count - i - 1] = temp
    }
    return reversedNums
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
            
assert(f(nums: [2, 6, 1, 3, 1]) == [1, 3, 1, 6, 2])
