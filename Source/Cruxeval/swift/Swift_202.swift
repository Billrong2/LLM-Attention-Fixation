func f(array: [Int], lst: [Int]) -> [Int] {
    var newArray = array
    newArray.append(contentsOf: lst)
    return newArray.filter { $0 >= 10 }
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
            
assert(f(array: [2, 15], lst: [15, 1]) == [15, 15])
