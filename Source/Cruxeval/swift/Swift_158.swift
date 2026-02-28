/// 
func f(arr: [Int]) -> [Int] {
    let n = arr.filter { $0 % 2 == 0 }
    var m = n + arr
    for i in m {
        if let index = m.firstIndex(of: i), index >= n.count {
            m.removeAll(where: { $0 == i })
        }
    }
    return m
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
            
assert(f(arr: [3, 6, 4, -2, 5]) == [6, 4, -2, 6, 4, -2])
