/// 
func f(char_freq: [String : Int]) -> [String : Int] {
    var result: [String: Int] = [:]
    for (k, v) in char_freq {
        result[k] = v / 2
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
            
assert(f(char_freq: ["u" : 20, "v" : 5, "b" : 7, "w" : 3, "x" : 3]) == ["u" : 10, "v" : 2, "b" : 3, "w" : 1, "x" : 1])
