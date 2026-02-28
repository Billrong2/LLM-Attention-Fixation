/// 
func f(xs: [Int]) -> [Int] {
    var xs = xs
    var new_x = xs.removeFirst() - 1
    
    while new_x <= xs[0] {
        xs.removeFirst()
        new_x -= 1
    }
    
    xs.insert(new_x, at: 0)
    
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
            
assert(f(xs: [6, 3, 4, 1, 2, 3, 5]) == [5, 3, 4, 1, 2, 3, 5])
