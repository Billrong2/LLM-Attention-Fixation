/// 
func f(nums: [Int]) -> [Int] {
    var l: [Int] = []
    
    for i in nums {
        if !l.contains(i) {
            l.append(i)
        }
    }
    
    return l
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
            
assert(f(nums: [3, 1, 9, 0, 2, 0, 8]) == [3, 1, 9, 0, 2, 8])
