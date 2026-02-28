/// 
func f(sb: String) -> [String : Int] {
    var d = [String: Int]()
    for s in sb {
        d[String(s)] = d[String(s), default: 0] + 1
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
            
assert(f(sb: "meow meow") == ["m" : 2, "e" : 2, "o" : 2, "w" : 2, " " : 1])
