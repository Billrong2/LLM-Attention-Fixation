/// 
func f(d: [String : Int]) -> [String : Int] {
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
            
assert(f(d: ["a" : 42, "b" : 1337, "c" : -1, "d" : 5]) == ["a" : 42, "b" : 1337, "c" : -1, "d" : 5])
