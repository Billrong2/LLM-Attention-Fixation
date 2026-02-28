/// 
func f(nums: [Int]) -> [Int] {
    var asc = nums
    var desc: [Int] = []
    var copy = asc
    copy.reverse()
    desc = Array(copy.prefix(copy.count/2))
    return desc + asc + desc
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
