/// 
func f(lst: [Int]) -> [Int] {
    var new = [Int]()
    var i = lst.count - 1
    for _ in 0..<lst.count {
        if i % 2 == 0 {
            new.append(-lst[i])
        } else {
            new.append(lst[i])
        }
        i -= 1
    }
    return new
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
            
assert(f(lst: [1, 7, -1, -3]) == [-3, 1, 7, -1])
