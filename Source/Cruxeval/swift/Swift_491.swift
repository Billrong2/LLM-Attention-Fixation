/// 
func f(xs: [Int]) -> [Int] {
    var xs = xs
    for i in 0..<xs.count {
        let reverseIndex = xs.count - i - 1
        xs.append(contentsOf: [xs[reverseIndex], xs[reverseIndex]])
    }
    return xs
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
            
assert(f(xs: [4, 8, 8, 5]) == [4, 8, 8, 5, 5, 5, 5, 5, 5, 5, 5, 5])
