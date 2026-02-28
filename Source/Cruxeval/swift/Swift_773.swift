/// 
func f(nums: [Int], n: Int) -> Int {
    var numsCopy = nums
    return numsCopy.remove(at: n)
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
            
assert(f(nums: [-7, 3, 1, -1, -1, 0, 4], n: 6) == 4)
