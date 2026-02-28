func f(nums: [Int], pos: Int) -> [Int] {
    var numsCopy = nums
    var s = numsCopy.startIndex..<numsCopy.endIndex
    if pos % 2 == 1 {
        s = s.lowerBound..<numsCopy.index(before: numsCopy.endIndex)
    }
    numsCopy[s].reverse()
    return numsCopy
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
            
assert(f(nums: [6, 1], pos: 3) == [6, 1])
