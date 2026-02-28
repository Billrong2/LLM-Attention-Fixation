/// 
func f(nums: [Int], val: Int) -> Int {
    var new_list: [Int] = []
    nums.forEach { num in
        new_list += Array(repeating: num, count: val)
    }
    return new_list.reduce(0, +)
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
            
assert(f(nums: [10, 4], val: 3) == 42)
