/// 
func f(nums: [Int], target: Int) -> ([Int], [Int]) {
    var lows: [Int] = []
    var higgs: [Int] = []
    
    for i in nums {
        if i < target {
            lows.append(i)
        } else {
            higgs.append(i)
        }
    }
    lows.removeAll()
    
    return (lows, higgs)
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
            
assert(f(nums: [12, 516, 5, 2, 3, 214, 51], target: 5) == ([] as [Int], [12, 516, 5, 214, 51]))
