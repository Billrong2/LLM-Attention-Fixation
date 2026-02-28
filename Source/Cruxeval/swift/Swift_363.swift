/// 
func f(nums: [Int]) -> [Int] {
    var sortedNums = nums.sorted()
    var newNums = [sortedNums[sortedNums.count/2]]
    
    if sortedNums.count % 2 == 0 {
        newNums = [sortedNums[sortedNums.count/2 - 1], sortedNums[sortedNums.count/2]]
    }
    
    for i in 0..<(sortedNums.count/2) {
        newNums.insert(sortedNums[sortedNums.count-i-1], at: 0)
        newNums.append(sortedNums[i])
    }
    
    return newNums
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
            
assert(f(nums: [1]) == [1])
