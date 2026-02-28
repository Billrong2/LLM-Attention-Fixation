/// 
func f(nums: [Int]) -> [Int] {
    var nums = nums
    var count = 0
    for i in 0..<nums.count {
        if nums.isEmpty {
            break
        }
        if count % 2 == 0 {
            nums.removeLast()
        } else {
            nums.removeFirst()
        }
        count += 1
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
            
assert(f(nums: [3, 2, 0, 0, 2, 3]) == [] as [Int])
