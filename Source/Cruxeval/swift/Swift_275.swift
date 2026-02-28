/// 
func f(dic: [Int : String]) -> [String : Int] {
    var dic2 = [String: Int]()
    for (key, value) in dic {
        dic2[value] = key
    }
    return dic2
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
            
assert(f(dic: [-1 : "a", 0 : "b", 1 : "c"]) == ["a" : -1, "b" : 0, "c" : 1])
