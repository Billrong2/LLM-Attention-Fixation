func f(nums: [Int], elements: [Int]) -> [Int] {
    var nums = nums
    for _ in elements {
        nums.removeLast()
    }
    return nums
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
            
assert(f(nums: [7, 1, 2, 6, 0, 2], elements: [9, 0, 3]) == [7, 1, 2])
