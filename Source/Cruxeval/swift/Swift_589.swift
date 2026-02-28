/// 
func f(num: [Int]) -> [Int] {
    var updatedNum = num
    updatedNum.append(num.last ?? 0)
    return updatedNum
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
            
assert(f(num: [-70, 20, 9, 1]) == [-70, 20, 9, 1, 1])
