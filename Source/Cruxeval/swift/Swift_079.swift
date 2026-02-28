func f(arr: [Int]) -> String {
    var arr = arr
    arr.removeAll()
    arr.append(1)
    arr.append(2)
    arr.append(3)
    arr.append(4)
    return arr.map { String($0) }.joined(separator: ",")
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
            
assert(f(arr: [0, 1, 2, 3, 4]) == "1,2,3,4")
