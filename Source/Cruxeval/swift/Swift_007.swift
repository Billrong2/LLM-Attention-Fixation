/// 
func f(list: [Int]) -> [Int] {
    var list = list
    var original = list
    while list.count > 1 {
        list.removeLast()
        for i in 0..<list.count {
            list.remove(at: i)
        }
    }
    list = original
    if !list.isEmpty {
        list.removeFirst()
    }
    return list
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
            
assert(f(list: [] as [Int]) == [] as [Int])
