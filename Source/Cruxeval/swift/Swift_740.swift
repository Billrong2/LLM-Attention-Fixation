/// 
func f(plot: [Int], delin: Int) -> [Int] {
    if plot.contains(delin) {
        if let split = plot.firstIndex(of: delin) {
            let first = Array(plot[..<split])
            let second = Array(plot[(split + 1)...])
            return first + second
        }
    }
    
    return plot
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
            
assert(f(plot: [1, 2, 3, 4], delin: 3) == [1, 2, 4])
