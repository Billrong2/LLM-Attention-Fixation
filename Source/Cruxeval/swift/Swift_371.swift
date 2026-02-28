/// 
func f(nums: [Int]) -> Int {
    var numsCopy = nums
    numsCopy.removeAll(where: { $0 % 2 != 0 })
    
    var sum = 0
    for num in numsCopy {
        sum += num
    }
    
    return sum
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
            
assert(f(nums: [11, 21, 0, 11]) == 0)
