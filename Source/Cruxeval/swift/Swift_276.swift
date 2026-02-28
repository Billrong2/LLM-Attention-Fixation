/// 
func f(a: [Int]) -> [Int] {
    var a = a
    if a.count >= 2 && a[0] > 0 && a[1] > 0 {
        a.reverse()
        return a
    }
    a.append(0)
    return a
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
            
assert(f(a: [] as [Int]) == [0])
