/// 
func f(dict: [Int : Int]) -> [Int : Int] {
    var result = dict
    dict.forEach { (k, v) in 
        if result.keys.contains(v) {
            result.removeValue(forKey: k)
        }
    }
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
            
assert(f(dict: [-1 : -1, 5 : 5, 3 : 6, -4 : -4]) == [3 : 6])
