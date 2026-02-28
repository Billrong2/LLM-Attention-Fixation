func f(start: Int, end: Int, interval: Int) -> Int {
    var steps = Array(stride(from: start, through: end, by: interval))
    if steps.contains(1) {
        steps[steps.count - 1] = end + 1
    }
    return steps.count
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
            
assert(f(start: 3, end: 10, interval: 1) == 8)
