/// 
func f(a: [Int]) -> [Int] {
    var b = a
    var k = 0
    while k < (a.count - 1) {
        b.insert(b[k], at: k + 1)
        k += 2
    }
    b.append(b[0])
    return b
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
            
assert(f(a: [5, 5, 5, 6, 4, 9]) == [5, 5, 5, 5, 5, 5, 6, 4, 9, 5])
