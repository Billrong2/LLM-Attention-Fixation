/// 
func f(d: [Int : Int], count: Int) -> [Int : Int] {
    var dict = d
    for _ in 0..<count {
        if dict.isEmpty {
            break
        }
        dict.removeValue(forKey: dict.keys.first!)
    }
    return dict
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
            
assert(f(d: [:] as [Int : Int], count: 200) == [:] as [Int : Int])
