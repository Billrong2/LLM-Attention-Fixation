func f(nums: [Int], n: Int) -> [Int] {
    var mutableNums = nums
    var pos = mutableNums.count - 1
    for i in stride(from: -mutableNums.count, to: 0, by: 1) {
        mutableNums.insert(mutableNums[i], at: pos)
    }
    return mutableNums
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
            
assert(f(nums: [] as [Int], n: 14) == [] as [Int])
