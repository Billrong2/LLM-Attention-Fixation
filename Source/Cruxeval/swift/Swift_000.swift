/// 
func f(nums: [Int]) -> [(Int, Int)] {
    var output: [(Int, Int)] = []
    for n in nums {
        output.append((nums.filter{$0 == n}.count, n))
    }
    output.sort { $0.0 > $1.0 }
    return output
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
            
assert(f(nums: [1, 1, 3, 1, 3, 1]) == [(4, 1), (4, 1), (4, 1), (4, 1), (2, 3), (2, 3)])
