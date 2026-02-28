/// 
func f(a: [String : Int], b: [String : Int]) -> [String : Int] {
    return a.merging(b) { _, new in new }
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
            
assert(f(a: ["w" : 5, "wi" : 10], b: ["w" : 3]) == ["w" : 3, "wi" : 10])
