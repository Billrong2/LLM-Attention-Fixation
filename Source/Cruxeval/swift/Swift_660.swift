/// 
func f(num: Int) -> Int {
    var initial = [1]
    var total = initial
    for _ in 0..<num {
        total = [1] + zip(total, total.dropFirst()).map { $0 + $1 }
        initial.append(total.last!)
    }
    return initial.reduce(0, +)
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
            
assert(f(num: 3) == 4)
