/// The function in Swift is similar to the original Python function, but Swift's `Array` type does not have the `insert` method, so we have to use `insert(contentsOf:at:)` instead.
func f(xs: [Int]) -> [Int] {
    var new_xs = xs
    for idx in stride(from: -new_xs.count , through: -1, by: -1) {
        new_xs.insert(contentsOf: [new_xs.removeFirst()], at: idx)
    }
    return new_xs
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
            
assert(f(xs: [1, 2, 3]) == [1, 2, 3])
