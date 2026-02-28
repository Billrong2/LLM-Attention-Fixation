func f(lst: [String]) -> [Int] {
    var lst = lst
    lst.removeAll()
    let result = Array(repeating: 1, count: lst.count + 1)
    return result
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
            
assert(f(lst: ["a", "c", "v"]) == [1])
