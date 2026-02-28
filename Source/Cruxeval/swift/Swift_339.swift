/// 
func f(array: [Int], elem: Int) -> Int {
    var d = 0
    let elemStr = String(elem)
    
    for i in array {
        if String(i) == elemStr {
            d += 1
        }
    }
    
    return d
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
            
assert(f(array: [-1, 2, 1, -8, -8, 2], elem: 2) == 2)
